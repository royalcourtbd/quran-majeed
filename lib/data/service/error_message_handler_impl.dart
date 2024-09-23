import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift/remote.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

/// The `ErrorMessageHandler` class helps to provide specific error handling and
/// make the error messages more user-friendly.
///
/// By creating an abstract class for error message handling and an
/// implementation class, like `ErrorMessageHandlerImpl`, we can have a central
/// place for handling errors throughout the app.
/// This makes it easier to maintain consistent error messages and ensures that
/// developers handle errors in a consistent manner.
///
/// Overall, creating an `ErrorMessageHandler` class and its implementation can
/// help to improve the quality of error handling and make the app more robust
/// and user-friendly.
class ErrorMessageHandlerImpl extends ErrorMessageHandler {
  @override
  String generateErrorMessage(Object? error) {
    if (error == null) return "An error has occurred";

    if (error is Error || error is Exception || error is String) {
      if (error is Error) return "Failed to retrieve data";
      if (error is IOException) {
        return "Please check if your mobile internet is turned on.";
      } else if (error is SocketException) {
        return "Failed to establish a connection with the server.";
      } else if (error is SqliteException) {
        return "Failed to load the database. Please try clearing the app data and reopening the app.";
      } else if (error is DriftRemoteException) {
        return "Failed to load data from the server.";
      } else if (error is InvalidDataException) {
        return "Your data is likely incorrect.";
      }
      return error.toString().replaceAll("Exception: ", "");
    }

    return "";
  }
}
