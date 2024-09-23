import 'package:equatable/equatable.dart';

// replace this with Dart 3 Record types, if possible.
class Pair<T1 extends Object, T2 extends Object> extends Equatable {
  const Pair(this.first, this.second);

  final T1 first;
  final T2 second;

  @override
  List<Object?> get props => [first, second];
}
