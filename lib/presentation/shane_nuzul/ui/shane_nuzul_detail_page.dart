import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/svg_path.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/appbar_action_icon.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';

class ShaneNuzulDetailPage extends StatelessWidget {
  ShaneNuzulDetailPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//TODO: Use Demo data for UI
  final String infoData = """
<html>

<head>
    <meta charset="UTF-8">
    <title>Shane Nuzul Page</title>
</head>
<body>
    <b>Name</b>
    <p>This Surah is named Al-Fatihah because of its subject matter. Fatihah is that which opens a subject or a book or any other thing. In other words, Al-Fatihah is a sort of preface.</p>
    <b>Period of Revelation</b>
    <p>Surah Al-Fatihah is one of the very earliest Revelations to the Holy Prophet. As a matter of fact, we learn from authentic traditions that it was the first complete Surah that was revealed to Muhammad (Allah's peace be upon him). Before this, only a few miscellaneous verses were revealed which form parts of Alaq, Muzzammil, Muddaththir, etc.</p>
    <b>Theme</b>
    <p>This Surah is in fact a prayer that Allah has taught to all those who want to make a study of His book. It has been placed at the very beginning of the Quran to teach this lesson to the reader: if you sincerely want to benefit from the Quran, you should offer this prayer to the Lord of the Universe. </br></br> This preface is meant to create a strong desire in the heart of the reader to seek guidance from the Lord of the Universe Who alone can grant it. Thus Al-Fatihah indirectly teaches that the best thing for a man is to pray for guidance to the straight path, to study the Quran with the mental attitude of a seeker searching for the truth, and to recognize the fact that the Lord of the Universe is the source of all knowledge. He should, therefore, begin the study of the Quran with a prayer to Him for guidance. </br></br> From this theme, it becomes clear that the real relation between Al-Fatihah and the Quran is not that of an introduction to a book but that of a prayer and its answer. Al-Fatihah is the prayer from the servant and the Quran is the answer from the Master to the servant's prayer. The servant prays to Allah to show him guidance and the Master places the whole of the Quran before him in answer to his prayer, as if to say, "This is the Guidance you begged from Me."</p>
</body>

</html>
""";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        theme: theme,
        title: 'Shane Nuzul',
        actions: [
          AppbarActionIcon(
            theme: theme,
            svgPath: SvgPath.icQuickTools,
            onIconTap: () {},
          ),
          gapW8,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: padding20,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      key: const Key("container"),
                      alignment: Alignment.center,
                      width: QuranScreen.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            key: const Key("image"),
                            SvgPath.imgNuzulMakka,
                            width: QuranScreen.width,
                            height: QuranScreen.width * 0.3,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text(
                                'Surah Al-Fatihah',
                                style: theme.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              gapH6,
                              Text(
                                'Maccan • 7 Verse',
                                style:
                                    context.quranText.lableExtraSmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: context.color.primaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    gapH10,
                    Html(
                      key: key,
                      data: infoData,
                      onAnchorTap: (url, _, __) => openUrl(url: url),
                      onLinkTap: (url, _, __) => openUrl(url: url),
                      style: {
                        "body": Style(
                          margin: Margins.zero,
                          textAlign: TextAlign.left,
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize(fourteenPx),
                          fontWeight: FontWeight.w400,
                          lineHeight: const LineHeight(1.4),
                          color: theme.textTheme.bodyMedium!.color,
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
