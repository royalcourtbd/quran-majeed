import 'package:equatable/equatable.dart';

class UpdateInfoEntity extends Equatable {
  const UpdateInfoEntity({
    required this.changeLog,
    required this.latestVersion,
    required this.forceUpdate,
    required this.askToUpdate,
    required this.title,
  });

  factory UpdateInfoEntity.empty() {
    return const UpdateInfoEntity(
      changeLog: '',
      latestVersion: '',
      forceUpdate: false,
      title: '',
      askToUpdate: false,
    );
  }

  final String changeLog;
  final String latestVersion;
  final bool forceUpdate;
  final String title;
  final bool askToUpdate;

  Future<UpdateInfoEntity> updateAskToUpdate({
    required String currentVersion,
  }) async {
    return UpdateInfoEntity(
      changeLog: changeLog,
      latestVersion: latestVersion,
      forceUpdate: forceUpdate,
      title: title,
      askToUpdate: currentVersion != latestVersion && forceUpdate,
    );
  }

  @override
  List<Object?> get props =>
      [changeLog, latestVersion, forceUpdate, title, askToUpdate];
}
