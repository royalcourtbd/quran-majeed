import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/data_sources/local_data/dua_category_data.dart';
import 'package:quran_majeed/presentation/dua/presenter/dua_ui_state.dart';

class DuaPresenter extends BasePresenter<DuaUiState> {
  DuaPresenter();

  final Obs<DuaUiState> uiState = Obs(DuaUiState.empty());

  int getTotalDuasForCategory(String categoryTitle) {
    var category = duaCategorydata.firstWhere(
      (category) => category.categoryTitle == categoryTitle,
      orElse: () => null,
    );
    if (category == null) {
      return 0;
    }
    return category.subCategories
        .fold(0, (total, subCat) => total + subCat.duaList.length);
  }

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = uiState.value.copyWith(isLoading: loading);
  }
}
