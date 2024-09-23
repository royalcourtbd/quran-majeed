import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_message.freezed.dart';

@freezed
class UserMessage with _$UserMessage {
  const factory UserMessage({
    required int id,
    required String message,
  }) = _UserMessage;

  factory UserMessage.setMessage(String message) {
    final int id = DateTime.now().millisecondsSinceEpoch;
    return UserMessage(id: id, message: message);
  }
  
}
