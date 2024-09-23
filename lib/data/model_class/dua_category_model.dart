class DuaSubCategoryModel {
  final String subCategoryTitle;
  final List<Map<String, String>> duaList;

  DuaSubCategoryModel({required this.subCategoryTitle, required this.duaList});
}

class DuaCategoryModel {
  final String iconPath;
  final String categoryTitle;
  final List<DuaSubCategoryModel> subCategories;

  DuaCategoryModel({
    required this.iconPath,
    required this.categoryTitle,
    required this.subCategories,
  });
}
