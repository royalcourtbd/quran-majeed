import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/shane_nuzul/presenter/shane_nuzul_ui_state.dart';

class ShaneNuzulPresenter extends BasePresenter {
  final Obs<ShaneNuzulUiState> uiState = Obs(ShaneNuzulUiState.empty());
  ShaneNuzulUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) {
    return showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
