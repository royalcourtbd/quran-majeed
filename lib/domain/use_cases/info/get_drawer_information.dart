import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/base/base_use_case.dart';
import 'package:quran_majeed/domain/repositories/info_repository.dart';
import 'package:quran_majeed/domain/service/error_message_handler.dart';

class GetDrawerInformationUseCase extends BaseUseCase<String> {
  GetDrawerInformationUseCase(
    this._infoRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  final InfoRepository _infoRepository;

  Future<Either<String, String>> execute({
    required DrawerInfo info,
  }) async =>
      mapResultToEither(() async => _getText(info));

  Future<String> _getText(DrawerInfo info) async {
    switch (info) {
      case DrawerInfo.donateUs:
        return _infoRepository.getDonateMessage();
      case DrawerInfo.libraries:
        return _infoRepository.getLibraryAddress();
      case DrawerInfo.aboutUs:
        return _infoRepository.getAboutOrganization();
      case DrawerInfo.contactUs:
        return _infoRepository.getContactUsMessage();
      case DrawerInfo.thanks:
        return _infoRepository.getThanksMessage();
      case DrawerInfo.volunteerHelp:
        return _infoRepository.getVolunteerHelp();
      case DrawerInfo.privacyPolicy:
        return _infoRepository.getPrivacyPolicy();
    }
  }
}

enum DrawerInfo {
  donateUs,
  libraries,
  aboutUs,
  contactUs,
  thanks,
  volunteerHelp,
  privacyPolicy,
}
