class RegexPatterns {
  RegexPatterns._();

  static final onlyNumbers = RegExp(r'^[1-9][0-9]*$');
  static final startsWithZeroOrSpace = RegExp(r'^(0|\s).*');
  static final onlyBanglaTexts = RegExp(r'^[\u0980-\u09FF\s]+$');
}
