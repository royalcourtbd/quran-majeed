// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserMessage {
  int get id => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserMessageCopyWith<UserMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMessageCopyWith<$Res> {
  factory $UserMessageCopyWith(
          UserMessage value, $Res Function(UserMessage) then) =
      _$UserMessageCopyWithImpl<$Res, UserMessage>;
  @useResult
  $Res call({int id, String message});
}

/// @nodoc
class _$UserMessageCopyWithImpl<$Res, $Val extends UserMessage>
    implements $UserMessageCopyWith<$Res> {
  _$UserMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserMessageCopyWith<$Res>
    implements $UserMessageCopyWith<$Res> {
  factory _$$_UserMessageCopyWith(
          _$_UserMessage value, $Res Function(_$_UserMessage) then) =
      __$$_UserMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String message});
}

/// @nodoc
class __$$_UserMessageCopyWithImpl<$Res>
    extends _$UserMessageCopyWithImpl<$Res, _$_UserMessage>
    implements _$$_UserMessageCopyWith<$Res> {
  __$$_UserMessageCopyWithImpl(
      _$_UserMessage _value, $Res Function(_$_UserMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? message = null,
  }) {
    return _then(_$_UserMessage(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserMessage implements _UserMessage {
  const _$_UserMessage({required this.id, required this.message});

  @override
  final int id;
  @override
  final String message;

  @override
  String toString() {
    return 'UserMessage(id: $id, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserMessage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserMessageCopyWith<_$_UserMessage> get copyWith =>
      __$$_UserMessageCopyWithImpl<_$_UserMessage>(this, _$identity);
}

abstract class _UserMessage implements UserMessage {
  const factory _UserMessage(
      {required final int id, required final String message}) = _$_UserMessage;

  @override
  int get id;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_UserMessageCopyWith<_$_UserMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
