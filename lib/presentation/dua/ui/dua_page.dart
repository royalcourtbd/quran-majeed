import 'package:flutter/material.dart';

import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/common/text_field/user_input_field.dart';
import 'package:quran_majeed/presentation/dua/widget/dua_category_list.dart';

class DuaPage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  DuaPage({
    super.key,
  });
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(
        theme: theme,
        title: 'Quranic Duas',
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
              isColored: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: twentyPx),
                child: Column(
                  children: [
                    gapH20,
                    SizedBox(
                      height: fortyFivePx,
                      child: UserInputField(
                        borderRadius: radius10,
                        textEditingController: textEditingController,
                        hintText: 'Search By Category',
                      ),
                    ),
                    gapH10,
                    DuaCategoryList(
                      theme: theme,
                    ),
                    gapH20,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
