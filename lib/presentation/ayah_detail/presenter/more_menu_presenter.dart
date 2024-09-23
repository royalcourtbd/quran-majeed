

import 'package:quran_majeed/core/base/base_presenter.dart';

import 'package:quran_majeed/presentation/ayah_detail/presenter/ui_state/more_menu_ui_state.dart';

class MoreMenuPresenter extends BasePresenter<MoreMenuUiState> {
  MoreMenuPresenter();

  final Obs<MoreMenuUiState> uiState = Obs(MoreMenuUiState.empty());

  @override
  Future<void> toggleLoading({required bool loading}) async {}

  @override
  Future<void> addUserMessage(String message) async {}




  MoreMenuUiState get currentUiState => uiState.value;
}
