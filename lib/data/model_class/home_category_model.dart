enum QuranCategory {
  last,
  musaf,
  hifz,
  support,
  apps,
  duas,
  nuzul,
  info,
}

class HomeCategoryModel {
  final String title;
  final String iconPath;
  final QuranCategory category;

  HomeCategoryModel({
    required this.title,
    required this.iconPath,
    required this.category,
  });
}
