import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quran_majeed/core/external_libs/simple_html_css/src/utils.dart';

import 'package:xml/xml_events.dart';

class _Tag {
  _Tag(this.name, this.styles, this.overrideStyle);

  String name;
  String styles;
  TextStyle? overrideStyle;
}

class Parser {
  Parser(
    this.context,
    String data, {
    this.defaultTextStyle,
    this.linksCallback,
    this.overrideStyleMap,
  }) {
    _events = parseEvents(data);
  }

  final List<_Tag> _stack = <_Tag>[];
  Iterable<XmlEvent> _events = <XmlEvent>[];
  final BuildContext context;
  final void Function(Object)? linksCallback;
  final Map<String, TextStyle>? overrideStyleMap;

  final TextStyle? defaultTextStyle;

  TextSpan _getTextSpan(String text, String style, TextStyle overrideStyle) {
    final Iterable<String> rules =
        style.split(';').where((String item) => item.trim().isNotEmpty);
    TextStyle textStyle = DefaultTextStyle.of(context).style;
    textStyle = textStyle.apply(color: const Color(0xff000000));
    textStyle = textStyle.merge(defaultTextStyle);

    bool isLink = false;
    String link = '';
    for (final String rule in rules) {
      if (rule.contains(':')) {
        final List<String> parts = rule.split(':');
        final String name = parts[0].trim();
        final String value = parts[1].trim();
        switch (name.toLowerCase()) {
          case 'color':
            textStyle = StyleGenUtils.addFontColor(textStyle, value);

          case 'background-color':
            textStyle = StyleGenUtils.addBgColor(textStyle, value);

          case 'font-weight':
            textStyle = StyleGenUtils.addFontWeight(textStyle, value);

          case 'font-style':
            textStyle = StyleGenUtils.addFontStyle(textStyle, value);

          case 'font-size':
            textStyle = StyleGenUtils.addFontSize(textStyle, value);

          case 'text-decoration':
            textStyle = StyleGenUtils.addTextDecoration(textStyle, value);

          case 'font-family':
            textStyle = StyleGenUtils.addFontFamily(textStyle, value);

          case 'line-height':
            textStyle = StyleGenUtils.addLineHeight(textStyle, value);

          // dropping partial support for li bullets
          // case 'list_item':
          // text = '• ' + text;
          // break;

          case 'visit_link':
            isLink = true;
            link = TextGenUtils.getLink(value);
        }
      }
    }

    textStyle = textStyle.merge(overrideStyle);

    if (isLink) {
      return TextSpan(
        style: textStyle,
        text: text,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (linksCallback != null) {
              linksCallback!(link);
            } else {
              debugPrint('Add a link callback to visit $link');
            }
          },
      );
    }
    return TextSpan(style: textStyle, text: text);
  }

  TextSpan _handleText(String text) {
    final String string = text;
    // string = TextGenUtils.strip(string);
    if (string.isEmpty) return const TextSpan(text: '');
    final StringBuffer style = StringBuffer();
    TextStyle textStyle = const TextStyle();
    for (final _Tag tag in _stack) {
      style.write('${tag.styles};');
      textStyle = textStyle.merge(tag.overrideStyle);
    }
    return _getTextSpan(string, style.toString(), textStyle);
  }

  List<TextSpan> parse() {
    List<TextSpan> spans = <TextSpan>[];
    for (final XmlEvent event in _events) {
      if (event is XmlStartElementEvent) {
        if (!event.isSelfClosing) {
          String styles = '';
          final String tagName = event.name.toLowerCase();
          TextStyle? overrideStyles;
          final double? defaultFontSize = defaultTextStyle?.fontSize;

          if (overrideStyleMap?.containsKey(tagName) ?? false) {
            overrideStyles = overrideStyleMap?[tagName];
          }

          switch (tagName) {
            case 'h1':
              double h1;
              if (defaultFontSize == null) {
                h1 =
                    Theme.of(context).textTheme.headlineSmall?.fontSize ?? 24.0;
              } else {
                h1 = defaultFontSize * 2;
              }
              styles = 'font-size: ${h1}px;';

            case 'h2':
              double h2;
              if (defaultFontSize == null) {
                h2 = Theme.of(context).textTheme.titleLarge?.fontSize ?? 20.0;
              } else {
                h2 = defaultFontSize * 1.5;
              }
              styles = 'font-size: ${h2}px; font-weight: medium;';

            case 'h3':
              double h3;
              if (defaultFontSize == null) {
                h3 = Theme.of(context).textTheme.titleMedium?.fontSize ?? 16.0;
              } else {
                h3 = defaultFontSize * 1.17;
              }
              styles = 'font-size: ${h3}px;';

            case 'h4':
              double h4;
              if (defaultFontSize == null) {
                h4 = Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16.0;
              } else {
                h4 = defaultFontSize;
              }
              styles = 'font-size: ${h4}px; font-weight: medium;';

            case 'h5':
              double h5;
              if (defaultFontSize == null) {
                h5 = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 16.0;
              } else {
                h5 = defaultFontSize * .83;
              }
              styles = 'font-size: ${h5}px; font-weight: bold;';

            case 'h6':
              double h6;
              if (defaultFontSize == null) {
                h6 = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14.0;
              } else {
                h6 = defaultFontSize * .67;
              }
              styles = 'font-size: ${h6}px; font-weight: bold;';

            case 'b':
              styles = 'font-weight: bold;';

            case 'strong':
              styles = 'font-weight: bold;';

            case 'i':
              styles = 'font-style: italic;';

            case 'em':
              styles = 'font-style: italic;';

            case 'u':
              styles = 'text-decoration: underline;';

            case 'strike':
              styles = 'text-decoration: line-through;';

            case 'del':
              styles = 'text-decoration: line-through;';

            case 's':
              styles = 'text-decoration: line-through;';

            case 'a':
              styles =
                  '''visit_link:__#TO_GET#__; text-decoration: underline; color: #4287f5;''';

// dropping partial support for ul-li bullets
//            case 'li':
//              styles = 'list_item:ul;';
//              break;
//              RichText(
//                text: TextSpan(
//                  text:'',
//                  style: TextStyle(color: Colors.black),
//                  children: <InlineSpan>[
//                    WidgetSpan(
//                        alignment: PlaceholderAlignment.baseline,
//                        baseline: TextBaseline.alphabetic,
//                        child: Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text( '• '),
//                            SizedBox(width: 20,),
//                            Expanded(child: Text('Example text',)),
//                          ],
//                        )
//                    ),
//                  ],
//                ),
//              )
          }

          for (final XmlEventAttribute attribute in event.attributes) {
            if (attribute.name == 'style') {
              styles = '$styles;${attribute.value}';
            } else if (attribute.name == 'href') {
              styles = styles.replaceFirst(
                '__#TO_GET#__',
                attribute.value.replaceAll(':', '__#COLON#__'),
              );
            }
          }
          _stack.add(_Tag(event.name, styles, overrideStyles));
        } else {
          if (event.name == 'br') {
            spans.add(const TextSpan(text: '\n'));
          }
        }
      }

      if (event is XmlEndElementEvent) {
        if (event.name == 'p' ||
            event.name == 'h1' ||
            event.name == 'h2' ||
            event.name == 'h3' ||
            event.name == 'h4' ||
            event.name == 'h5' ||
            event.name == 'h6' ||
            event.name == 'div') {
          spans.add(const TextSpan(text: '\n\n'));
        } else if (event.name == 'li') {
          spans.add(const TextSpan(text: '\n'));
        } else if (event.name == 'ul' || event.name == 'ol') {
          spans.add(const TextSpan(text: '\n'));
        }

        if (_stack.isNotEmpty) {
          final _Tag top = _stack.removeLast();
          if (top.name != event.name) {
            debugPrint('Malformed HTML');
            return const <TextSpan>[];
          }
        } else {
          debugPrint('Malformed HTML. Starting TAG missing');
        }
      }

      if (event is XmlTextEvent) {
        final TextSpan currentSpan = _handleText(event.value);
        if (currentSpan.text?.isNotEmpty ?? false) {
          spans.add(currentSpan);
        }
      }
    }

    // removing all extra new line textSpans to avoid space at the bottom
    if (spans.isNotEmpty) {
      final List<TextSpan> reversed = spans.reversed.toList();

      while (reversed.isNotEmpty &&
          (reversed.first.text == '\n\n' || reversed.first.text == '\n')) {
        reversed.removeAt(0);
      }
      spans = reversed.reversed.toList();
    } else {
      debugPrint('Empty HTML content');
    }
    return spans;
  }
}
