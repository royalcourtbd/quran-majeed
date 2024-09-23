import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/subject_wise/ui/subject_wise_page.dart';
import 'package:quran_majeed/presentation/subject_wise/ui/view_subject_wise_page.dart';
import 'package:quran_majeed/presentation/subject_wise/widgets/custom_scroll_bar.dart';
import 'package:quran_majeed/presentation/subject_wise/widgets/topic_list_item.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  TopicListState createState() => TopicListState();
}

class TopicListState extends State<TopicList> {
  final ScrollController _scrollController = ScrollController();
  String _currentLetter = 'A';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateCurrentLetter(double scrollOffset) {
    final int firstVisibleItemIndex = (scrollOffset / 72).floor();
    if (firstVisibleItemIndex < topics.length) {
      setState(() {
        _currentLetter = topics[firstVisibleItemIndex].name[0].toUpperCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              _updateCurrentLetter(scrollNotification.metrics.pixels);
            }
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              final letter = topic.name[0].toUpperCase();
              final showLetter = index == 0 ||
                  letter != topics[index - 1].name[0].toUpperCase();

              return TopicListItem(
                topic: topic,
                showLetter: showLetter,
                letter: letter,
                theme: theme,
                onTap: () => context.navigatorPush(ViewSubjectWisePage()),
              );
            },
          ),
        ),
        Positioned(
          right: twoPx,
          bottom: thirtyPx,
          top: thirtyPx,
          child: CustomScrollbar(
            theme: theme,
            currentLetter: _currentLetter,
            onLetterSelected: (letter) {
              final index =
                  topics.indexWhere((topic) => topic.name.startsWith(letter));
              if (index != -1) {
                _scrollController.animateTo(
                  index * 72.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
