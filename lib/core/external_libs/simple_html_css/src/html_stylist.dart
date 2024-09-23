import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/simple_html_css/html_unscape/html_unescape.dart';
import 'package:quran_majeed/core/external_libs/simple_html_css/src/copy_share_context_menu.dart';
import 'package:quran_majeed/core/external_libs/simple_html_css/src/internals.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';


class HTML {
  HTML._();

  static TextSpan toTextSpan(
    BuildContext context,
    String htmlContent, {
    void Function(Object)? linksCallback,
    Map<String, TextStyle>? overrideStyle,
    TextStyle? defaultTextStyle,
  }) {
    // Validating empty content
    if (htmlContent.isEmpty) return const TextSpan();

    String content = htmlContent;

    // to fix a known issue with &nbsp; when appearing after an ending tag
    content = content.replaceAll('&nbsp;', ' ').replaceAll('&nbsp', ' ');

    // to fix a known issue with non self closing <br> tags
    content = content.replaceAll('<br>', '<br />');
    final Parser parser = Parser(
      context,
      HtmlUnescape().convert(content),
      linksCallback: linksCallback,
      overrideStyleMap: overrideStyle ?? <String, TextStyle>{},
      defaultTextStyle: defaultTextStyle,
    );

    List<TextSpan> list = <TextSpan>[];
    catchVoid(() => list = parser.parse());

    return TextSpan(children: list);
  }

  static SelectableText toRichText(
    BuildContext context,
    String htmlContent, {
    void Function(Object)? linksCallback,
    Map<String, TextStyle>? overrideStyle,
    TextStyle? defaultTextStyle,
  }) {
    return SelectableText.rich(
      toTextSpan(
        context,
        htmlContent,
        linksCallback: linksCallback,
        overrideStyle: overrideStyle,
        defaultTextStyle: defaultTextStyle,
      ),
      key: const Key("SelectableTextToRichText28423"),
      contextMenuBuilder: (context, editableTextState) {
        return CopyShareContextMenu(
          anchor: editableTextState.contextMenuAnchors.primaryAnchor,
          editableTextState: editableTextState,
        );
      },
    );
  }
}
