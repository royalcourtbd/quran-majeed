import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/musaf/presenter/musaf_ui_state.dart';

class MusafPagePresenter extends BasePresenter<MusafPageUiState> {
  final Obs<MusafPageUiState> uiState = Obs(MusafPageUiState.empty());

  MusafPageUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) {
    uiState.value = uiState.value.copyWith(isLoading: loading);
    return Future.value();
  }
}