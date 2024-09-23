class NoInternetException implements Exception {
  final String message = "Please turn on the internet";

  @override
  String toString() => message;
}

class SignInException implements Exception {
  final String message = "Sign in failed";

  @override
  String toString() => message;
}

class InvalidNotificationException implements Exception {
  final String message = "Invalid notification";

  @override
  String toString() => message;
}
