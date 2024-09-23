import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_presenter.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/data/mappers/word_by_word_json_mapper.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/delete_wbw_language_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/download_wbw_language_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_available_wbw_languages_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_downloaded_wbw_languages_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/get_selected_wbw_language_use_case.dart';
import 'package:quran_majeed/domain/use_cases/word_by_word/set_selected_wbw_language_use_case.dart';
import 'package:quran_majeed/presentation/collections/ui/components/remove_dialog.dart';
import 'package:quran_majeed/presentation/word_by_word/presenter/word_by_word_ui_state.dart';

class WordByWordPresenter extends BasePresenter<WordByWordUiState> {
  final GetAvailableWbwLanguagesUseCase _getAvailableWbwLanguagesUseCase;
  final GetDownloadedWbwLanguagesUseCase _getDownloadedWbwLanguagesUseCase;
  final DownloadWbwLanguageUseCase _downloadWbwLanguageUseCase;
  final DeleteWbwLanguageUseCase _deleteWbwLanguageUseCase;
  final SetSelectedWbwLanguageUseCase _setSelectedWbwLanguageUseCase;
  final GetSelectedWbwLanguageUseCase _getSelectedWbwLanguageUseCase;

  WordByWordPresenter(
    this._getAvailableWbwLanguagesUseCase,
    this._getDownloadedWbwLanguagesUseCase,
    this._downloadWbwLanguageUseCase,
    this._deleteWbwLanguageUseCase,
    this._setSelectedWbwLanguageUseCase,
    this._getSelectedWbwLanguageUseCase,
  );

  final Obs<WordByWordUiState> uiState = Obs(WordByWordUiState.empty());
  final Map<String, CancelToken> _cancelTokens = {};

  WordByWordUiState get currentUiState => uiState.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await toggleLoading(loading: true);
    await _loadDownloadedLanguages();
    await _loadAvailableLanguages();
    await _loadSelectedLanguage();
    await toggleLoading(loading: false);
  }

  Future<void> _loadAvailableLanguages() async {
    final result = await _getAvailableWbwLanguagesUseCase.execute();
    result.fold(
      (failure) => addUserMessage(failure),
      (wbwJsonModel) {
        final List<WbwDbFileModel> availableLanguages = wbwJsonModel.wordbyword
            .where((language) => !currentUiState.downloadedLanguages.contains(language.name))
            .toList();

        uiState.value = currentUiState.copyWith(
          availableLanguages: availableLanguages,
        );
      },
    );
  }

  Future<void> _loadDownloadedLanguages() async {
    final result = await _getDownloadedWbwLanguagesUseCase.execute();
    result.fold(
      (failure) => addUserMessage(failure),
      (downloadedLanguages) {
        uiState.value = currentUiState.copyWith(
          downloadedLanguages: downloadedLanguages,
        );
      },
    );
  }

  Future<void> _loadSelectedLanguage() async {
    final result = await _getSelectedWbwLanguageUseCase.execute();
    result.fold(
      (failure) => addUserMessage(failure),
      (selectedLanguage) => uiState.value = currentUiState.copyWith(
        selectedLanguage: selectedLanguage,
      ),
    );
  }

  Future<void> downloadLanguage({required WbwDbFileModel wbwFile}) async {
    if (currentUiState.isDownloading) {
      if (currentUiState.activeDownloadId == wbwFile.name) {
        cancelDownload();
        return addUserMessage("Download Cancelled.");
      } else {
        return addUserMessage("Please wait for the current download to finish.");
      }
    }

    uiState.value = currentUiState.copyWith(
      isDownloading: true,
      activeDownloadId: wbwFile.name,
      downloadProgress: 0,
    );

    final result = await _downloadWbwLanguageUseCase.execute(
      wbwFile: wbwFile,
      onProgress: (progress) {
        uiState.value = currentUiState.copyWith(downloadProgress: progress);
      },
      cancelToken: _addCancelToken(wbwFile),
    );

    result.fold(
      (failure) {
        if (failure == "Download cancelled") {
          addUserMessage(failure);
        } else {
          addUserMessage("Failed to download language");
        }
        uiState.value = currentUiState.copyWith(
          isDownloading: false,
          activeDownloadId: null,
          downloadProgress: 0,
        );
      },
      (_) async {
        await _loadDownloadedLanguages();
        await _loadAvailableLanguages();
        addUserMessage("Language downloaded successfully");
        uiState.value = currentUiState.copyWith(
          isDownloading: false,
          activeDownloadId: null,
          downloadProgress: 0,
        );
      },
    );
  }

  CancelToken _addCancelToken(WbwDbFileModel file) {
    final CancelToken cancelToken = CancelToken();
    _cancelTokens[file.name] = cancelToken;
    return cancelToken;
  }

  void cancelDownload() {
    if (currentUiState.isDownloading) {
      _cancelTokens[currentUiState.activeDownloadId]?.cancel();

      uiState.value = currentUiState.copyWith(
        isDownloading: false,
        activeDownloadId: null,
        downloadProgress: 0,
      );
      addUserMessage("Download cancelled");
    }
  }

  Future<void> deleteLanguage({required String fileName, required BuildContext context}) async {
    if (['Bangla', 'English'].contains(fileName)) {
      addUserMessage("Cannot delete default languages");
      return;
    }

    await RemoveDialog.show(
      title: "Remove Bookmark",
      context: context,
      onRemove: () async {
        final bool isCurrentlySelected = currentUiState.selectedLanguage == fileName;
        final Either<String, WbwJsonModel> availableLanguagesResult = await _getAvailableWbwLanguagesUseCase.execute();
        final WbwDbFileModel? wbwFile = availableLanguagesResult.fold(
          (failure) {
            addUserMessage(failure);
            return null;
          },
          (wbwJsonModel) {
            return wbwJsonModel.wordbyword.firstWhere((element) => element.name == fileName);
          },
        );
        final deletedFile = await _deleteWbwLanguageUseCase.execute(file: wbwFile!);
        deletedFile.fold(
          (failure) => addUserMessage(failure),
          (_) async {
            await _loadDownloadedLanguages();
            await _loadAvailableLanguages();
            if (isCurrentlySelected) {
              await setSelectedLanguage(fileName: currentUiState.downloadedLanguages.first);
            }
            addUserMessage("Language deleted successfully");
          },
        );
      },
    );
  }

  Future<void> setSelectedLanguage({required String fileName}) async {
    final result = await _setSelectedWbwLanguageUseCase.execute(fileName: fileName);
    result.fold(
      (failure) => addUserMessage(failure),
      (_) async {
        await _loadSelectedLanguage();
        addUserMessage("Selected language updated");
      },
    );
  }

  @override
  Future<void> addUserMessage(String message) async => showMessage(message: message);

  @override
  Future<void> toggleLoading({required bool loading}) async =>
      uiState.value = currentUiState.copyWith(isLoading: loading);
}
