import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/data/service/database/database_service.dart';
import 'package:quran_majeed/data/service/local_cache_service.dart';
import 'package:quran_majeed/domain/entities/our_project_entity.dart';
import 'package:quran_majeed/domain/entities/notification/promotional_message_entity.dart';

class InfoLocalDataSource {
  InfoLocalDataSource(
    this._localCacheService,
    this._quranDatabase,
  );

  final LocalCacheService _localCacheService;
  final QuranDatabase _quranDatabase;

  Future<String> getAboutApp() async {
    // final DrawerDto aboutApp =
    //     await _quranDatabase.getDrawerItemByName(name: Drawer.aboutApp);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getVolunteerHelp() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(
    //   name: Drawer.getVolunteerHelp,
    // );
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getAboutOrganization() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.aboutUs);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getContactUsMessage() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.contactUs);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getDonateMessage() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.donate);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getHelpUsMessage() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.helpUs);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getLibraryAddress() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.libraryAddress);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getThanksMessage() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.thanks);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getTopTenApps() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.bugReport);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getPrivacyPolicy() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.privacy);
    // return aboutApp.textBn;
    return '';
  }

  Future<String> getPublicationAndTranslatorsInfo() async {
    // final DrawerDto aboutApp = await _quranDatabase.getDrawerItemByName(name: Drawer.libraryAddress);
    // return aboutApp.textBn;
    return '';
  }

  Future<void> savePromotionalMessageShown({
    required int promotionalMessageId,
  }) async {
    await _localCacheService.saveData(
      key: CacheKeys.promotionalMessageId,
      value: promotionalMessageId,
    );
  }

  Future<bool> shouldPublishPromotionalMessage({
    required PromotionalMessageEntity notification,
  }) async {
    final bool? shouldPublish = await catchAndReturnFuture(() {
      if (notification.id < 0) return false;
      final int? previousMessageId = _localCacheService.getData<int>(
        key: CacheKeys.promotionalMessageId,
      );

      final bool shouldShow =
          (previousMessageId == null || previousMessageId != notification.id) &&
              notification.publish;
      return shouldShow;
    });
    return shouldPublish ?? false;
  }

  Future<List<OurProjectEntity>> getOtherProjects() async {
    return [
      const OurProjectEntity(
        id: 4,
        banglaName: 'IRD Official Website',
        englishName: 'www.IrdFoundation.com',
        icon: 'assets/images/png/ird_logo.png',
        banglaDescription:
            "আমাদের বর্তমানে পরিচালিত প্রজেক্টসমূহ ও অ্যাপসমূহ সম্পর্কে তথ্য পেতে আমাদের অফিসিয়াল ওয়েবসাইট এখনই ভিজিট করুন।",
        englishDescription:
            "Visit our official website now to obtain information about our ongoing app projects.",
        websiteLink: 'https://www.irdfoundation.com',
        actionMessage: "Download",
      ),
      const OurProjectEntity(
        id: 3,
        banglaName: "আল হাদিস",
        englishName: 'Al Hadith',
        icon: 'assets/images/png/hadithapp.png',
        banglaDescription:
            "আল হাদিসে পাচ্ছেন আল্লাহ্‌র রাসুল (ﷺ)-এর হাদিস সমূহের সুবিশাল কালেকশন। বিশুদ্ধ হাদিস গ্রন্থগুলো সহ অ্যাপে রয়েছে ৪৯,০০০ এরও বেশি হাদিসের সমাহার। ",
        englishDescription:
            "Al Hadith is an Great Collection of Hadith of Prophet Muhammad (ﷺ). The app contains 49000+ hadith from Most Accepted and Authentic Hadith books.",
        appStoreLink: 'https://itunes.apple.com/us/app/al-hadith/id1238182914',
        websiteLink: 'http://www.ihadis.com',
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.ihadis.ihadis',
        actionMessage: "Download",
      ),
      const OurProjectEntity(
        id: 2,
        banglaName: "কুরআন মাজীদ (Tafsir & by Words)",
        englishName: "Quran Mazid (Tafsir & by Words)",
        icon: 'assets/images/png/quranapp.png',
        banglaDescription:
            "কুরআন মাজীদ (বাংলা) তাফসীর সহ সাজিয়েছি। হাফেজী কোরআন শরীফ, নূরানী কোরআন শরীফ এবং  সহজ সরল বাংলা অনুবাদ এই সব কিছু একসাথেই পাচ্ছে আমাদের এই অ্যাপটিতে। আমাদের অ্যাপটি সম্পূর্ণ অ্যাড ফ্রি।  যে কোন আয়াত এ ক্লিক করলে তাফসীর দেখার অপশন আসবে। অখানে ক্লিক করে তাফসীর দেখা যাবে। ড্রপডাউন থেকে কোন তাফসীর তা সিলেক্ট করা যাবে।",
        englishDescription:
            "Quran Mazid is one of the most Popular Quran App with 34000+ Reviews and 4.8/5 Ratings. In Our app will get almost all important features like Multiple Translations, Multiple Tafsirs, Word By Word with Audio, Quran Recitation, Quran Index etc.",
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.ihadis.quran',
        appStoreLink: 'https://apps.apple.com/us/app/quran-mazid/id1324615850',
        websiteLink: 'http://www.quranmazid.com',
        actionMessage: "Download",
      ),
      const OurProjectEntity(
        id: 1,
        banglaName: 'দোয়া ও রুকিয়াহ (হিসনুল মুসলিম)',
        englishName: 'Dua & Ruqyah (Hisnul Muslim)',
        icon: 'assets/images/png/duaapp.png',
        banglaDescription:
            "দোয়া ও রুকিয়াহ তে রয়েছে কুরআন এবং হাদিস থেকে সংকলিত সহীহ দোয়া ও যিকিরের সবচেয়ে বড় সংগ্রহ। এতে মোট ৪১ টি ক্যাটাগরিতে ৮৯০+ টি দোয়া ও যিকির পাবেন। এই অ্যাপে প্রধানত কুরআন ও সহিহ হাদিস ভিত্তিক দোয়াগুলো আনা হয়েছে। এই অ্যাপের অন্যতম বড় ফিচার হচ্ছে রুকিয়াহ (ইসলামিক ঝাড়-ফুঁক) সেকশন। এখানে আপনি রুকিয়াহ মিডিয়া প্লেয়ার এর পাশাপাশি রুকিয়াহ সম্পর্কিত বিভিন্ন গুরুত্বপূর্ণ তথ্য যেমন যাদু, বদনজরের চিকিৎসা সম্পর্কে জানতে পারবেন। এই অ্যাপে কোন প্রকার অ্যাড নেই এবং এটি সম্পূর্ণ ফ্রী !",
        englishDescription:
            "The Dua and Ruqyah app have the largest collection of Sahih Dua and Zikr compiled from the Qur'an and Sahih Hadith. You will get 890+ prayers and dhikr in 41 categories. Various categories of Duas for all occasions such as morning and evening, Children, Prayer, Ramadan, Hajj/Umrah, and Quran Duas can be found here.",
        playStoreLink:
            'https://play.google.com/store/apps/details?id=com.ihadis.dua',
        appStoreLink: 'https://apps.apple.com/us/app/dua-ruqyah/id1568942398',
        websiteLink: 'https://www.duaruqyah.com',
        actionMessage: "Download",
      ),
    ];
  }
}
