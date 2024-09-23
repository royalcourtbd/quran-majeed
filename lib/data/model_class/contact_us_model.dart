import 'package:equatable/equatable.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/utility/utility.dart';

class ContactUsModel extends Equatable {
  const ContactUsModel({
    required this.name,
    required this.icon,
    this.onLinkClick,
  });

  final String name;
  final String icon;
  final void Function()? onLinkClick;

  @override
  List<Object?> get props => [name, icon, onLinkClick];
}

const List<ContactUsModel> contactList = [
  ContactUsModel(
    name: "FB Page",
    icon: SvgPath.icFab,
    onLinkClick: launchFacebookPage,
  ),
  ContactUsModel(
    name: "Messenger",
    icon: SvgPath.icFbMes,
    onLinkClick: launchMessenger,
  ),
  ContactUsModel(
    name: "Gmail",
    icon: SvgPath.icGmail,
    onLinkClick: sendEmail,
  ),
  ContactUsModel(
    name: "FB Group",
    icon: SvgPath.icFbGroup,
    onLinkClick: launchFacebookGroup,
  ),
  ContactUsModel(
    name: "Twitter",
    icon: SvgPath.icTwitter,
    onLinkClick: launchTwitter,
  ),
  ContactUsModel(
    name: "Youtube",
    icon: SvgPath.icYoutube,
    onLinkClick: launchYoutube,
  ),
];
