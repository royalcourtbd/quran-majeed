import 'package:flutter/material.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/static/ui_const.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/app_bar/custom_appbar.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/settings/presenter/settings_presenter.dart';

class ConfigOptionsPage extends StatelessWidget {
  ConfigOptionsPage({
    super.key,
    required this.configList,
    required this.presenter,
    required this.title,
  });

  final Map<String, String> configList;
  final SettingsPresenter presenter;
  final String title;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _globalKey,
      appBar: CustomAppBar(
        title: title,
        theme: theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: RoundedScaffoldBody(
                isColored: true,
                key: const Key("ConfigOptionsPage"),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: configList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      bool isSelected = configList.values.elementAt(index) ==
                          presenter.appLanguageList.entries
                              .toList()[presenter.languageSelectIndex.value]
                              .value;
                      return InkWell(
                        onTap: () {
                          context.navigatorPop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: index == 0 ? tenPx : 0),
                          padding: EdgeInsets.only(left: twentyPx, top: fivePx),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 0.8,
                                child: Radio(
                                  value: configList.values.elementAt(index),
                                  activeColor: context.color.primaryColor,
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) => isSelected
                                        ? context.color.primaryColor
                                        : context.color.primaryColor
                                            .withOpacity(0.38),
                                  ),
                                  groupValue: presenter.appLanguageList.entries
                                      .toList()[
                                          presenter.languageSelectIndex.value]
                                      .value,
                                  onChanged: (val) {},
                                ),
                              ),
                              gapW15,
                              Text(
                                configList.values.elementAt(index),
                                style: theme.textTheme.labelSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          )
        ],
      ),
    );
  }
}
