import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_majeed/core/config/quran_screen.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/common/rounded_scaffold_body.dart';
import 'package:quran_majeed/presentation/grammar/widget/grammer_custom_appbar.dart';
import 'package:quran_majeed/presentation/grammar/widget/section_boundary_row.dart';
import 'package:quran_majeed/presentation/grammar/widget/arabic_word_list_widget.dart';
import 'package:quran_majeed/presentation/grammar/widget/select_text_button.dart';
import 'package:quran_majeed/presentation/grammar/widget/word_wrap_container.dart';

class GrammarPage extends StatelessWidget {
  GrammarPage({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      key: _globalKey,
      body: Column(
        children: [
          GrammarCustomAppbar(
            key: const Key('GrammarCustomAppbar'),
            theme: theme,
          ),
          Expanded(
            child: RoundedScaffoldBody(
              key: const Key('RoundedScaffoldBody'),
              isColored: true,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: twentyPx,
                      right: twentyPx,
                      top: twentyPx,
                      bottom: tenPx,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Words: 18',
                          style: theme.textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SelectTextButton(
                          theme: theme,
                          text: context.l10n.selectAll,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const WordWrapContainer(
                        key: Key('WordWrapContainer'),
                        height: 22,
                        isGrid: true,
                      ),
                      GestureDetector(
                        onTap: () => HapticFeedback.lightImpact(),
                        child: const SectionBoundaryRow(
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  ArabicWordListWidget(
                    theme: theme,
                    onNotification: (ScrollNotification notification) {
                      return true;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
