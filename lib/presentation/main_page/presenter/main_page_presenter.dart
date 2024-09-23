import 'package:flutter/material.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/di/service_locator.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/ayah_detail/presenter/ayah_presenter.dart';
import 'package:quran_majeed/data/sealed_classes/surah_ayah_presenter.dart';
import 'package:quran_majeed/presentation/ayah_detail/widgets/bottom_sheet/select_surah_ayah_bottom_sheet.dart';
import 'package:quran_majeed/presentation/main_page/presenter/main_page_ui_state.dart';
import 'package:quran_majeed/presentation/main_page/widgets/drawer/pages/info_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPagePresenter extends BasePresenter<MainPageUiState> {
  late final GlobalKey<ScaffoldState> mainScaffoldKey =
      GlobalKey<ScaffoldState>();
  late final AyahPresenter ayahPresenter = locate<AyahPresenter>();

  final Obs<MainPageUiState> uiState = Obs(MainPageUiState.empty());

  MainPageUiState get currentUiState => uiState.value;

  void changeTabIndex(int index) {
    uiState.value = currentUiState.copyWith(currentIndex: index);
  }

  void closeDrawer() {
    mainScaffoldKey.currentState?.closeDrawer();
  }

  void onCLickOnDrawerButton() {
    final ScaffoldState? state =
        locate<MainPagePresenter>().mainScaffoldKey.currentState;
    if (state == null) return;
    state.isDrawerOpen ? state.closeDrawer() : state.openDrawer();
  }

  Future<void> launchEmailApp() async {
    final emailUri = Uri.parse('mailto:project.ihadis@gmail.com');
    if (await canLaunchUrl(emailUri)) launchUrl(emailUri);
  }

  Future<void> openJumpToAyahBottomSheet(BuildContext context) async {
    await SelectSurahAyahBottomSheet.show(
      context: context,
      bottomSheetTitle: context.l10n.jumpToAyah,
      isDoneButtonEnabled: false,
      isJumpToAyahBottomSheet: true,
      presenter: SurahAyahPresenter.ayah(locate<AyahPresenter>()),
      onSubmit: () {
        context.navigatorPop();
        closeDrawer();
        ayahPresenter.goToAyahPageWithSurahAndAyahID(
          context: context,
          surahID: ayahPresenter.currentUiState.selectedSurahIndex + 1,
          ayahID: ayahPresenter.currentUiState.selectedAyahIndex + 1,
        );
      },
      onJumpToTafseer: () async => await ayahPresenter.goToTafseerPage(
        context: context,
        surahID: ayahPresenter.currentUiState.selectedSurahIndex + 1,
        ayahID: ayahPresenter.currentUiState.selectedAyahIndex + 1,
      ),
      onAyahSelected: (ayahId) => ayahPresenter.onSelectAyah(ayahId),
      onSurahSelected: (surahId) => ayahPresenter.onSelectSurah(surahId),
    );
  }

  Future<void> onTapPrivacyPolicy(BuildContext context) async {
    // this information will come from database or from api
    String information = """
    <style>
    ul {
        list-style-type: disc;
     
    }
    ul li {
        margin-left: 5px; /* Adjust the space as needed */
        
    }
</style>

<h4 class='header' style='color: #614730;'>19th September, 2018</h4>
<p>We started in 2012. At first, we were working to make a complete database of hadith. We successfully did that and published Al-Hadith Android and iOS Apps. We also launched a website for hadiths (<a href="http://ihadis.com/">http://ihadis.com/</a>). Next, we moved on to work with Quran Tafsir and Translation. We launched an Android Quran App and website. Now we are trying to enhance our existing projects and also working on different ideas for different projects that will, by the will of Allah (Suhanahu Wa Ta'ala), benefit the Ummah. So dear brothers and sisters, keep us in your duas.</p>
<br/>
<h4 class='header' style='color: #614730;'>Collection Of Your Information</h4>
<p>We may collect information about you in a variety of ways. The information we may collect via the application depends on the content and materials you use and includes:</p>
<br/>
<h4 class='header' style='color: #614730;'>Personal Data</h4>
<p>We may collect information about you in a variety of ways. The information we may collect via the application depends on the content and materials you use and includes:</p>
""";

    // await _presenter.fetchThanks();
    if (context.mounted) {
      await context.navigatorPush<void>(
        InfoPage(
          title: context.l10n.privacyPolicy,
          information: information,
        ),
      );
    }
  }

  Future<void> onClickSadaqa(BuildContext context) async {
    // this information will come from database or from api
    String information = """
<html>

<head>
    <meta charset="UTF-8">
    <title>Sadaqah Jariyah Page</title>
</head>

<body>


    <p>We have plans for many more useful Islamic apps and websites. So if you want all these projects to continue and reach millions of brothers and sisters with the message of Islam, then support us as much as possible every month or once.</p>
    <p>Even \$10 dollar per month will take the project a long way, InshaAllah. If you help in this work, it will be added to your account of akhirah as a sadaqa zaria, In sha Allah, the stream of rewards will continue even after your death In sha Allah.</p>
    <p><span style="color: #614730; font-weight: bold;">Prophet Muhammad (ﷺ) Said:</span> He who called (people) to Righteousness, there would be reward (assured) for him like the rewards of those who adhered to it, without their rewards being diminished in any respect. (Sahih Muslim: 2674)</p>


    <p><strong style="color: #614730;">NOTE:</strong> Please be aware that we do not accept Zakah. You can support us by giving Hadiyah (Gift).</p>

</body>

</html>
""";

    // await _presenter.fetchThanks();
    if (context.mounted) {
      await context.navigatorPush<void>(
        InfoPage(
          title: context.l10n.sadaqahJariah,
          information: information,
          showDonationButton: true,
          coverPhoto: 'img_sadaqa',
        ),
      );
    }
  }

  Future<void> onClickThanks(BuildContext context) async {
    // this information will come from database or from api
    String information = """
                        <style>
                        ul {
                            list-style-type: disc;
                            padding-left: 10px;
                        }
                        ul li {
                            margin-left: 5px; /* Adjust the space as needed */
                            margin-bottom: 5px;
                        }
                    </style>
                    
                    <h2 class='header' style='color: #614730;'>Special Thanks to All of Our - </h2>
                    <ul>
                        <li>Honorable Donors For their Financial Support.</li>
                        <li>Volunteers For their Technical and Others Support.</li>
                        <li>Workers For their hard work for Projects.</li>
                        <li>Bangla Hadith For Tafsir Ahsanul Bayan Database.</li>
                        <li>IERF and Shaikh Shaidullah Khan Madanni for Tafsir Fathul Mazid.</li>
                    </ul>
                    <h4>Greentech Apps Foundation For - </h4>
                    <ul>
                        <li>Main Quran Database.</li>
                        <li>Word By Word Database.</li>
                        <li>English and Arabic Tafsir Database.</li>
                        <li>Tajweed Color Codes</li>
                        <li>Some other Code help</li>
                    </ul>
                  """;
    // await _presenter.fetchThanks();
    if (context.mounted) {
      await context.navigatorPush<void>(
        InfoPage(
          title: context.l10n.thanksAndCredit,
          coverPhoto: "thanks_credit",
          information: information,
        ),
      );
    }
  }

  Future<void> onClickAboutUs(BuildContext context) async {
    // this information will come from database or from api
    String information = """
    <h2 class='header'>Assalamu alaikum dear brothers and sisters,</h2>
    <p>We are Digital Apps BD, We provide Islamic applications to the Ummah, expecting rewards from Allah Subhana’wa ta’ala alone. Since 2012, we have been working to produce authentic, high quality, user friendly Islamic apps. With Allah's grace, we have already launched 2 Android Applications, 2 iOS Applications and 2 Websites, Alhamdulillah! Currently, we are in the process to bring more exciting features to our apps, make corrections where necessary. Alhamdulillah our apps have reached a lot people already.Best of all they are completely FREE and have NO ADS.</p>

                  """;
    // await _presenter.fetchThanks();
    if (context.mounted) {
      await context.navigatorPush<void>(
        InfoPage(
          title: context.l10n.aboutUs,
          coverPhoto: "about_us",
          information: information,
        ),
      );
    }
  }

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
