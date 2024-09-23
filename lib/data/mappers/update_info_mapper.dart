import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/service/running_compute.dart';
import 'package:quran_majeed/domain/entities/update_info_entity.dart';

Future<UpdateInfoEntity> convertJsonToUpdateInfo({
  required Map<String, dynamic> json,
}) async {
  final UpdateInfoEntity? updateInfo = await catchAndReturnFuture(
    () async => compute(_convertJsonToUpdateInfo, json),
  );
  return updateInfo ?? UpdateInfoEntity.empty();
}

Future<UpdateInfoEntity> _convertJsonToUpdateInfo(
  Map<String, dynamic> json,
) async {
  return UpdateInfoEntity(
    changeLog: json['change_log'] as String? ??
        "Quran Majeed has some new features and bug fixes.",
    latestVersion: json['version'] as String? ?? "2.7.2",
    forceUpdate: json['force_update'] as bool? ?? false,
    title: json['title'] as String? ?? "Update Now!!!",
    askToUpdate: false,
  );
}
