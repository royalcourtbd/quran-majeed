import 'package:quran_majeed/core/static/svg_path.dart';

class OurProjectModel {
  String title, description, icon;
  final String? appLink, website;
  OurProjectModel({
    required this.title,
    required this.description,
    required this.icon,
    this.appLink,
    this.website,
  });
}

List<OurProjectModel> ourProjectList = [
  OurProjectModel(
    title: "Quran Mazid (Tafsir & Word)",
    description:
        "We are Digital Apps BD, We provide Islamic applications to the Ummah, expecting rewards from Allah Subhana’wa ta’ala alone.",
    icon: SvgPath.icQuranMazid,
    appLink: "www.irdfoundation.com",
    website: "www.quranmazid.com",
  ),
  OurProjectModel(
    title: "Dua & Ruqyah",
    description:
        "We are Digital Apps BD, We provide Islamic applications to the Ummah, expecting rewards from Allah Subhana’wa ta’ala alone.",
    icon: SvgPath.icDuaRuqyah,
    appLink: "www.irdfoundation.com",
    website: "www.irdfoundation.com",
  ),
  OurProjectModel(
    title: "Al Hadith",
    description:
        "We are Digital Apps BD, We provide Islamic applications to the Ummah, expecting rewards from Allah Subhana’wa ta’ala alone.",
    icon: SvgPath.icAlHadith,
    appLink: "www.irdfoundation.com",
    website: "www.ihadis.com",
  ),
  OurProjectModel(
    title: "IRD Foundation",
    description:
        "We are Digital Apps BD, We provide Islamic applications to the Ummah, expecting rewards from Allah Subhana’wa ta’ala alone.",
    icon: SvgPath.icIrd,
    website: "https://www.irdfoundation.com/",
  ),
];
