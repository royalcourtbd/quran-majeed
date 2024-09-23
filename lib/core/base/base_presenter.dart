import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

import 'base_ui_state.dart';

// Function to load a presenter of type T that extends BasePresenter
T loadPresenter<T extends BasePresenter>(T presenter) => Get.put(presenter);

// Function to unload a presenter of type T that extends BasePresenter
void unloadPresenterManually<T extends BasePresenter>() => Get.delete<T>();

// Abstract class BasePresenter with generic type U that extends BaseUiState
abstract class BasePresenter<U extends BaseUiState> extends GetxController {
  // Function to toggle loading state
  Future<void> toggleLoading({required bool loading});

  // Function to add user message
  Future<void> addUserMessage(String message);

  // Function to handle stream events
  @protected
  Future<void> handleStreamEvents<T>({
    required Stream<Either<String, T>> stream,
    required void Function(T) onData,
    required StreamSubscription<Either<String, T>>? subscription,
  }) async {
    await subscription?.cancel();
    subscription = stream.listen(
          (result) => result.fold(addUserMessage, onData),
      onError: (Object e) => addUserMessage(e.toString()),
      onDone: () async => subscription?.cancel(),
    );
  }

  // Function to execute a task with loading state
  @protected
  Future<void> executeTaskWithLoading(FutureOr<void> Function() task) async {
    await toggleLoading(loading: true);
    await task();
    await toggleLoading(loading: false);
  }

  // Function to execute a use case that only shows a message
  @protected
  Future<void> executeMessageOnlyUseCase(
      FutureOr<Either<String, String>> Function() task, {
        bool showMessage = true,
        VoidCallback? onSuccess,
      }) async {
    await toggleLoading(loading: true);
    final Either<String, String> result = await task();
    await result.fold(addUserMessage, (message) async {
      if (showMessage) await addUserMessage(message);
      onSuccess?.call();
    });
    await toggleLoading(loading: false);
  }

  // Function to parse data from Either with user message
  @protected
  Future<void> parseDataFromEitherWithUserMessage<T>({
    required FutureOr<Either<String, T>> Function() task,
    required void Function(T) onDataLoaded,
    bool showLoading = false,
    T? valueOnError,
  }) async {
    if (showLoading) await toggleLoading(loading: true);
    final Either<String, T> result = await task();
    result.fold(
          (message) {
        addUserMessage(message);
        if (valueOnError != null) onDataLoaded(valueOnError);
      },
      onDataLoaded,
    );
    if (showLoading) await toggleLoading(loading: false);
  }

  // Function to map data from Either with user message
  @protected
  Future<T?> mapDataFromEitherWithUserMessage<T>({
    required FutureOr<Either<String, T>> Function() task,
    bool showLoading = false,
  }) async {
    T? data;
    if (showLoading) await toggleLoading(loading: true);
    final Either<String, T> result = await task();
    if (showLoading) await toggleLoading(loading: false);
    result.fold(addUserMessage, (d) => data = d);
    return data;
  }
}

// Class Obs that extends Rx with generic type T
class Obs<T> extends Rx<T> {
  Obs(super.initial);
}
