/// A utility class for commonly used font families in the app.
///
/// Provides constants for commonly used font families
///
/// Using this class to access the font families
/// ensures that there are no typos or spelling mistakes in the font
/// family names.
///
/// Note that hardcoding the font family names in the app's code can
/// lead to potential mistakes and inconsistencies if the font family
/// names change or if different developers use different spellings
/// for the same font family.
///
/// By using constants from this class, we ensure that all the font family names
/// are consistent and easily editable from a single location.
///
/// For example, we can switch to a different font package or a different
/// implementation of the 'GoogleFonts' package without changing the code that
/// uses the 'Hind Siliguri' font family.
class FontFamily {
  FontFamily._();

  static const String inter = 'Inter';
  static const String kfgq = 'KFGQ';
  static const String meQuran = 'MeQuran';
  static const String suraNames = 'SuraNames';
  static const String cinzelDecorative = 'CinzelDecorative';
  static const String surahName2 = 'QuranSurah';
  static const String koho = 'KoHo';
  static const String alMushaf = 'AlMushaf';
  static const String alQalamKolkatta = 'AlQalamKolkatta';
  static const String kalpurush = 'Kalpurush';
  static const String hafsSmart = 'HafsSmart';
  static const String kitab = 'Kitab';
  static const String uthmanicHafs1 = 'UthmanicHafs1';
  static const String uthmanTN1 = 'UthmanTN1';
  static const String uthmanTN1B = 'UthmanTN1B';
  static const String alQalamQuranMajeed = 'AlQalamQuranMajeed';
  static const String amiriQuran = 'AmiriQuran';
  static const String lateef = 'Lateef';
  static const String nooreHidayat = 'NooreHidayat';
  static const String nooreHira = 'NooreHira';
  static const String nooreHuda = 'NooreHuda';
  static const String pdmsSaleem = 'PDMS_Saleem';
  static const String pdmsIslamic = 'PDMS_Islamic';
}
