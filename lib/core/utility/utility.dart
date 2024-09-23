import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_majeed/core/config/quran_custom_text_theme.dart';
import 'package:quran_majeed/core/config/quran_custom_theme_colors.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/external_libs/services/keyboard_service.dart';
import 'package:quran_majeed/core/external_libs/svg_image.dart';
import 'package:quran_majeed/core/external_libs/throttle_service.dart';
import 'package:quran_majeed/core/static/constants.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/number_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/surah_entity.dart';
import 'package:quran_majeed/presentation/quran_majeed.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart' as rs;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

bool get isMobile => rs.Device.screenType == rs.ScreenType.mobile;

ColorFilter buildColorFilterToChangeColor(Color? color) =>
    ColorFilter.mode(color ?? Colors.black, BlendMode.srcATop);

extension ContextExtensions on BuildContext {
  Future<T?> navigatorPush<T>(Widget page) async {
    try {
      if (!mounted) return null;
      final CupertinoPageRoute<T> route =
          CupertinoPageRoute<T>(builder: (context) => page);
      return Navigator.push<T>(this, route);
    } catch (e) {
      logError("Failed to navigate to ${e.runtimeType} -> $e");
      return null;
    }
  }

  // Generic navigation method with custom transition
  void customNavigatorPush(BuildContext context, Widget nextPage) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => nextPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0,
              1.0); // Starting point of the animation (bottom of the screen)
          var end = Offset
              .zero; // End at the current screen position (top of the screen)
          var curve = Curves.ease; // Animation curve

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  Future<T?> navigatorPushReplacement<T>(Widget page) async {
    try {
      if (!mounted) return null;
      final CupertinoPageRoute<T> route =
          CupertinoPageRoute<T>(builder: (context) => page);
      return Navigator.pushReplacement(this, route);
    } catch (e) {
      logError("Failed to navigate to ${e.runtimeType} -> $e");
      return null;
    }
  }

  Future<T?> showBottomSheetLegacy<T>(Widget bottomSheet) async {
    return Get.bottomSheet<T>(
      bottomSheet,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
          topRight: Radius.circular(twentyPx),
        ),
      ),
    );
  }

  Future<T?> showBottomSheet<T>(
      Widget bottomSheet, BuildContext context) async {
    if (!mounted) return null;
    final T? result = await showModalBottomSheet<T>(
      context: context,
      builder: (BuildContext context) => bottomSheet,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
          topRight: Radius.circular(twentyPx),
        ),
      ),
    );
    return result;
  }

  void navigatorPop<T>({T? result}) {
    if (!mounted) return;
    Navigator.pop(this, result);
  }
}

String getSurahType({
  required String type,
  required BuildContext context,
}) {
  switch (type) {
    case 'Meccan':
      return context.l10n.meccan;
    case 'Medinan':
      return context.l10n.medinan;
    default:
      return 'Invalid type';
  }
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

Future<void> copyText({required String text}) async {
  await catchFutureOrVoid(() async {
    if (text.isEmpty) return;
    final ClipboardData clipboardData = ClipboardData(text: text);
    await Clipboard.setData(clipboardData);
  });
}

Future<void> shareText({required String text}) async {
  await catchFutureOrVoid(() async => Share.share(text));
}

/// Helper extension that allows to use a color like:
/// `context.color.primary`
extension ThemeContextExtension on BuildContext {
  QuranCustomThemeColors get color {
    return Theme.of(this).extension<QuranCustomThemeColors>()!;
  }
}

/// Helper extension that allows to use custom text styles like:
/// `context.quranText.arabicTitle`
extension QuranTextThemeExtension on BuildContext {
  QuranCustomTextTheme get quranText {
    return Theme.of(this).extension<QuranCustomTextTheme>()!;
  }
}

/// Displays a message asynchronously.
///
///
/// Example usage:
///
/// ```dart
/// showMessage(message: 'Error occurred!');
/// ```
///
/// Rationale:
///
/// - provides a convenient way to display short messages to the user
/// as toast notifications within your Flutter application.
/// - encapsulates the logic of showing the message with a specified duration,
/// toast position, and styling.
Future<void> showMessage({
  required String? message,
  BuildContext? context,
}) async {
  if (message == null || message.isEmpty) return;
  Debounce.debounce("showMessageLock", 10.inMilliseconds, () async {
    final ThemeData themeData = (context ?? QuranMajeed.globalContext).theme;
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: themeData.primaryColor.withOpacity(0.9),
      textColor: Colors.white,
      fontSize: sixteenPx,
    );
  });
}

extension IntDateExtension on int? {
  DateTime get fromTimestampToDateTime {
    if (this == null) return DateTime.now();
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this!);
    return date;
  }
}

extension ColorExtension on String {
  Color toColor() {
    String hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    // Return a default color if the conversion fails
    return Colors.black;
  }
}

String getCurrentLanguage(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}

String getTranslatedSurahName(
    {required SurahEntity surah, required BuildContext context}) {
  String currentLanguage = getCurrentLanguage(context);
  if (currentLanguage == 'ar') {
    return surah.name;
  } else if (currentLanguage == 'bn') {
    return surah.nameBn;
  } else {
    return surah.nameEn;
  }
}

String getMeaningOfSurah({
  required SurahEntity surah,
  required BuildContext context,
}) {
  String currentLanguage = getCurrentLanguage(context);
  if (currentLanguage == 'ar') {
    return surah.name;
  } else if (currentLanguage == 'bn') {
    return surah.meaningBn;
  } else {
    return surah.meaning;
  }
}

isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

Future<void> showComingSoonMessage({
  required BuildContext context,
}) async {
  Debounce.debounce("showComingSoonMessageLock", 10.milliseconds, () async {
    try {
      await Fluttertoast.showToast(
        msg: context.l10n.comingSoon,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: context.color.primaryColor.withOpacity(0.9),
        textColor: context.color.whiteColor,
        fontSize: sixteenPx,
      );
    } catch (e) {
      logErrorStatic(e, _fileName);
    }
  });
}

/// Checks the internet connection asynchronously.
///
///
/// Example usage:
///
/// ```dart
/// bool isConnected = await checkInternetConnection();
/// if (isConnected) {
///   logDebug('Internet connection is available.');
/// } else {
///   logDebug('No internet connection.');
/// }
/// ```
///
/// Rationale:
///
/// The `checkInternetConnection` function provides a straightforward way to determine
/// the availability of an internet connection within your Flutter application. By performing
/// a lookup for a well-known URL, it checks if the device can successfully resolve the URL's
/// IP address, indicating an active internet connection.
///
Future<bool> checkInternetConnection() async {
  final bool? isConnected = await catchAndReturnFuture(() async {
    const String kLookUpUrl = 'www.cloudflare.com';
    final List<InternetAddress> result =
        await InternetAddress.lookup(kLookUpUrl);
    if (result.isEmpty) return false;
    if (result.first.rawAddress.isEmpty) return false;
    return true;
  });
  return isConnected ?? false;
}

const String reportEmailAddress = 'report.irdfoundation@gmail.com';
const String donationUrl = 'https://irdfoundation.com/sadaqa-jaria.html';
const String messengerUrl = "https://m.me/ihadis.official";
const String twitterUrl = "https://twitter.com/irdofficial";
const String facebookGroupUrl = "https://www.facebook.com/groups/irdofficial";
const String facebookPageUrl = "https://www.facebook.com/ihadis.official";

Future<String> getEmailBody() async {
  final String reportInfo = await getDeviceInfo();
  final String currentVersion = await currentAppVersion;
  return '''
যে সমস্যাটি রিপোর্ট করছেন: 

App Version: $currentVersion
ডিভাইস ইনফরমেশন:
${reportInfo.replaceAll(" ", ' ')}
''';
}

/// Sends an email asynchronously with the specified subject, body, and email address.
///
/// Example usage:
///
/// ```dart
/// await sendEmail(subject: 'Feedback', body: 'Hello, I have some feedback...');
/// ```
///
/// Rationale:
///
/// - provides a simple way to send emails asynchronously from within
/// your Flutter application.
/// - encapsulates the process of composing an email with the
/// specified subject, body, and recipient address,
/// abstracting away the complexities of
/// integrating with the device's default email client.
Future<void> sendEmail({
  String subject = "",
  String body = "",
  String email = reportEmailAddress,
}) async {
  String emailBody = body;
  if (emailBody.isEmpty) emailBody = await getEmailBody();

  final Map<String, String> mailContent = {
    'subject': subject,
    'body': emailBody
  };
  final Uri uri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: mailContent,
  );
  final String urlString = uri.toString();
  await openUrl(url: urlString);
}

/// Launches the Facebook page of the app or opens a fallback URL in a browser
/// if the Facebook app is not installed on the user's device.
///
/// First checks if the user's device is an iOS device or not and then
/// generates a protocol URL to launch the Facebook page.
/// If the URL can be launched, it is launched, else it opens the fallback URL.
///
/// This function makes use of openUrl() function to launch the URL, and the
/// fallback URL is set to the official Facebook page URL of the app.
///
/// If the URL can be launched, it opens the Facebook page in the Facebook app,
/// otherwise, it opens the fallback URL in a browser.
Future<void> launchFacebookPage() async {
  final String fbProtocolUrl = Platform.isIOS
      ? 'fb://profile/436269339900162'
      : 'fb://page/436269339900162';
  await openUrl(url: fbProtocolUrl, fallbackUrl: facebookPageUrl);
}

Future<void> launchFacebookGroup() async {
  const String fbProtocolUrl = 'fb://group/irdofficial';
  await openUrl(url: fbProtocolUrl, fallbackUrl: facebookGroupUrl);
}

Future<void> launchYoutube() async {
  const String channelId = 'UCnVaqAxLkEz9uCqkvJlPK8A';
  final String youtubeProtocolUrl = Platform.isIOS
      ? 'youtube://channel/$channelId'
      : 'https://www.youtube.com/channel/$channelId';
  const String fallbackUrl = 'https://www.youtube.com/channel/$channelId';
  await openUrl(url: youtubeProtocolUrl, fallbackUrl: fallbackUrl);
}

Future<void> launchTwitter() async {
  await launchUrl(Uri.parse(twitterUrl));
}

Future<void> launchMessenger() async {
  const String facebookId = "436269339900162";

  final String fbProtocolUrl = Platform.isAndroid
      ? 'fb-messenger://user/$facebookId'
      : 'https://m.me/$facebookId';

  await openUrl(url: fbProtocolUrl, fallbackUrl: facebookPageUrl);
}

String getAudioPathForSurah(int surahNumber, Reciter reciter) {
  String directoryPath = p.join('audio', reciter.name);
  String fileName = '$surahNumber.mp3';
  return p.join(directoryPath, fileName);
}

/// Formats the given [duration] into a string representation.
///
/// The [duration] parameter represents the duration to be formatted.
/// Returns a string representation of the formatted duration.
String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

/// Returns the file path for the given [fileName] in the specified [directoryPath].
///
/// If the file does not exist, it returns an empty string.
Future<bool> fileExists(
    {required String directoryPath, required String fileName}) async {
  final String filePath = '$directoryPath/$fileName';
  final bool isFileExists = await File(filePath).exists();
  return isFileExists;
}

/// get application directory path
Future<String> getApplicationDirectoryPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<bool> doesFileExist(String filePath) async {
  final bool isFileExists = await File(filePath).exists();
  return isFileExists;
}

Future<String> getDatabaseFilePath(String fileName) async {
  final directoryPath = await getApplicationDirectoryPath();
  return join(directoryPath, fileName);
}

Future<File> getDatabaseFile({required String fileName}) async {
  final String dbPath = await getDatabaseFilePath(fileName);
  final File file = File(dbPath);
  return file;
}

Future<void> moveDatabaseFromAssetToInternal({
  required String assetPath,
  required File file,
}) async {
  await catchFutureOrVoid(() async {
    // ignore: avoid_slow_async_io
    final bool databaseExists = await file.exists();
    if (databaseExists) return;

    final ByteData blob = await rootBundle.load(assetPath);
    final ByteBuffer buffer = blob.buffer;
    final Uint8List dbAsBytes =
        buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes);

    await file.parent.create(recursive: true);
    await file.create(recursive: true);

    await writeFileAsBytesInIsolate(file, dbAsBytes);
  });
}

Future<void> writeFileAsBytesInIsolate(File file, List<int> dbAsBytes) async {
  await compute(_writeFileAsBytes, (file, dbAsBytes));
}

bool _writeFileAsBytes((File, List<int>) param) {
  catchAndReturn(() {
    final (file, dbAsBytes) = param;
    file.writeAsBytesSync(dbAsBytes);
    return true;
  });
  return false;
}

String? _currentAppVersion;

Future<String> get currentAppVersion async {
  if (_currentAppVersion == null) {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _currentAppVersion = packageInfo.version;
  }
  return _currentAppVersion!;
}

/// this function will check the fileName
/// if fileName mached with the file then it will return true else false
bool isNonDefaultTafseer(String fileName) {
  return ["bn_fmazid", "bn_kathir", "bn_tafsir_kathir_mujibor"]
      .contains(fileName);
}

/// Opens a URL asynchronously with optional fallback URL.
///
/// Example usage:
///
/// ```dart
/// await openUrl(url: 'https://facebook.com/irdfoundation');
/// ```
///
/// Rationale:
///
/// - provides a convenient way to open a URL asynchronously with an
/// optional fallback URL.
/// - utilizes the `Throttle` class to throttle multiple invocations
/// within a specified time interval, ensuring that the function is not called too frequently.
///
Future<void> openUrl({
  required String? url,
  String fallbackUrl = "",
}) async {
  Throttle.throttle("openUrlThrottle", 1.inSeconds, () async {
    await catchFutureOrVoid(() async {
      if (url == null) return;
      if (url.trim().isEmpty) return;

      final Uri? uri = Uri.tryParse(url);
      final Uri? fallbackUri = Uri.tryParse(fallbackUrl);

      final bool validFallbackUri = fallbackUri != null;
      final bool validUri = uri != null;

      const String errorMessage = "দুঃখিত। লোড করা সম্ভব হয়নি।";

      try {
        final bool canLaunch =
            validUri && (Platform.isAndroid || await canLaunchUrl(uri));

        if (canLaunch) {
          bool isLaunched =
              await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (isLaunched) return;

          isLaunched = await launchUrl(uri);
          if (isLaunched) return;
        }

        if (!validUri) {
          await showMessage(message: errorMessage);
          return;
        }

        validFallbackUri
            ? await launchUrl(fallbackUri, mode: LaunchMode.externalApplication)
            : await showMessage(message: errorMessage);
      } catch (e) {
        logErrorStatic(e, _fileName);
        validFallbackUri
            ? await launchUrl(fallbackUri)
            : await showMessage(message: errorMessage);
      }
    });
  });
}

const String _fileName = "utility.dart";

String get suitableAppStoreUrl =>
    Platform.isAndroid ? playStoreUrl : appStoreUrl;

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

Null Function(Object _)? doNothing(_) => null;

/// Retrieves the device information asynchronously.
///
/// Example usage:
///
/// ```dart
/// String deviceInfo = await getDeviceInfo();
/// print(deviceInfo);
/// ```
///
/// Rationale:
///
/// - The `getDeviceInfo` function provides a convenient way to retrieve device information
/// asynchronously.
/// - Utilizes the `catchAndReturnFuture` method to handle any errors that
/// might occur during the execution of the asynchronous code.
Future<String> getDeviceInfo() async {
  final String? deviceInfo = await catchAndReturnFuture(() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceModel = "";

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
    }

    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceModel = "${iosInfo.utsname.machine}-${iosInfo.model}";
    }

    return "OS: ${Platform.operatingSystem}\n"
        "OS Version: ${Platform.operatingSystemVersion}\n"
        "Device Model: $deviceModel\n";
  });

  return deviceInfo ?? "";
}

Future<void> disposeKeyboard(
    BuildContext context, TextEditingController editingController,
    {FocusNode? focusNode}) async {
  editingController.clear();
  KeyboardService.dismiss(
    context: context,
  );
}

extension DateTimeExtension on DateTime {
  int get toTimestamp => millisecondsSinceEpoch;
}

InputDecoration inputDecorateBottomSheet({
  required BuildContext context,
  required String hintText,
  required BorderRadius borderRadius,
  bool enabled = true,
  String? suffixIconPath,
  String? prefixIconPath,
  EdgeInsetsGeometry? contentPadding,
  Color? prefixIconColor,
  double? borderWidth,
  Color? borderColor,
  Color? fillColor,
}) {
  // final MoreMenuUiState uiState = _presenter.currentUiState;
  final ThemeData theme = Theme.of(context);
  final TextTheme textTheme = theme.textTheme;

  return InputDecoration(
    enabled: enabled,
    border: outlineInputBorder(
      context: context,
      borderRadius: borderRadius,
      borderWidth: borderWidth ?? 0.8,
      borderColor: borderColor ?? Colors.transparent,
    ),
    focusedBorder: outlineInputBorder(
      context: context,
      borderRadius: borderRadius,
      borderWidth: borderWidth ?? 0.8,
      borderColor: borderColor ?? Colors.transparent,
    ),
    enabledBorder: outlineInputBorder(
      context: context,
      borderRadius: borderRadius,
      borderWidth: borderWidth ?? 0.8,
      borderColor: borderColor ?? Colors.transparent,
    ),
    disabledBorder: outlineInputBorder(
      context: context,
      borderRadius: borderRadius,
      borderWidth: borderWidth ?? 0.8,
      borderColor: borderColor ?? Colors.transparent,
    ),
    contentPadding: contentPadding ?? padding5,
    hintText: hintText,
    filled: true,
    fillColor: fillColor ?? theme.cardColor,
    hintStyle: textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: isMobile ? thirteenPx : eightPx,
      color: context.color.subtitleColor,
    ),
    suffixIcon: suffixIconPath != null
        ? SvgImage(
            suffixIconPath,
            fit: BoxFit.scaleDown,
            color: theme.primaryColor,
          )
        : null,
    prefixIcon: prefixIconPath != null
        ? Padding(
            padding: padding5,
            child: SvgImage(
              prefixIconPath,
              fit: BoxFit.scaleDown,
              color: prefixIconColor ?? theme.primaryColor,
            ),
          )
        : null,
  );
}

OutlineInputBorder outlineInputBorder(
    {required BuildContext context,
    required BorderRadius borderRadius,
    double? borderWidth,
    Color? borderColor}) {
  return OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: BorderSide(
      width: borderWidth ?? 0.8,
      color: borderColor ?? Colors.transparent,
    ), // BorderSide
  );
}

void hideStatusBar() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  });
}

Future<void> onNotificationMenuTapped({
  required BuildContext context,
  required TimeOfDay currentDefault,
  required dynamic presenter,
}) async {
  final MediaQueryData mediaQuery = MediaQuery.of(context);
  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    builder: (BuildContext context, Widget? child) {
      return Localizations(
        locale: const Locale('en', 'US'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: MediaQuery(
          data: mediaQuery.copyWith(
            alwaysUse24HourFormat: false,
          ),
          child: Theme(
            data: context.theme.copyWith(
              timePickerTheme: TimePickerThemeData(
                helpTextStyle: context.textTheme.bodyMedium!
                    .copyWith(fontSize: fourteenPx),
                backgroundColor: context.color.backgroundColor,
                dialBackgroundColor: context.color.cardShade,
                dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return context
                        .color.primaryColor; // White text when selected
                  }
                  return context.textTheme.bodySmall!.color!
                      .withOpacity(0.6); // Light brown text when not selected
                }),
                dayPeriodBorderSide: BorderSide(
                  color: context.color.primaryColor
                      .withOpacity(0.5), // Light brown border
                  width: 1.2,
                ),
                dialTextColor: WidgetStateColor.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white; // White text when selected
                    }
                    return context.textTheme.bodyMedium!
                        .color!; // Black text when not selected
                  },
                ),
                hourMinuteColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return context
                        .color.primaryColor; // Primary color when selected
                  }
                  return context
                      .theme.cardColor; // Adjusted card color for dark mode
                }),
                hourMinuteTextColor: WidgetStateColor.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white; // White text when selected
                    }
                    return context.textTheme.bodyMedium!
                        .color!; // Black text when not selected
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              textTheme: TextTheme(
                displayMedium: TextStyle(
                  color: context.theme.textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.bold,
                ),
                displayLarge: TextStyle(
                  color: context.color.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                // this is for title
                bodyMedium: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 16,
                  wordSpacing: .5,
                  letterSpacing: .5,
                ),

                labelLarge: TextStyle(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              colorScheme: ColorScheme.light(
                onSurface: context.color.primaryColor.withOpacity(0.5),
                secondary: context.color.primaryColor.withOpacity(0.5),
                primary: context.color.primaryColor,
              ),
            ),
            child: child!,
          ),
        ),
      );
    },
    initialTime: currentDefault,
    helpText: context.l10n.setNotificationTime,
    cancelText: context.l10n.cancel,
    initialEntryMode: TimePickerEntryMode.dialOnly,
    confirmText: context.l10n.ok,
  );
  if (selectedTime == null) return;
  await presenter.setNotificationTime(notificationTime: selectedTime);
}
