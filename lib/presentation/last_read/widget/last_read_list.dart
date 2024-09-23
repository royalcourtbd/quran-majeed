import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/entities/last_read_entity.dart';
import 'package:quran_majeed/presentation/last_read/widget/last_read_item.dart';

class LastReadList extends StatelessWidget {
  const LastReadList({super.key, required this.lastReadList});

  final List<LastReadEntity> lastReadList;

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: lastReadList.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              return LastReadItem(
                index: index,
                lastReadList: lastReadList,
              );
            },
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: tenPx),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: QuranScreen.width * 0.18,
                  mainAxisSpacing: fivePx,
                  crossAxisSpacing: fivePx),
              padding: EdgeInsets.zero,
              itemCount: lastReadList.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return LastReadItem(
                  index: index,
                  lastReadList: lastReadList,
                );
              },
            ),
          );
  }
}
