import 'dart:convert';
import 'dart:math';

// Character constants.
const int _hashCodeUnit = 35; // #
const int _minDecimalEscapeLength = 4; // x
const int _minHexadecimalEscapeLength = 5; // &#0;
const int _xCodeUnit = 120; // &#x0;

/// An abstract class that converts from HTML5-escaped strings
/// to unicode strings using [keys] and [values].
abstract class HtmlUnescapeBase extends Converter<String, String> {
  /// Constructs a new converter.
  HtmlUnescapeBase() {
    _chunkLength = max(maxKeyLength, _minHexadecimalEscapeLength);
  }

  late int _chunkLength;

  /// A list of keys (such as `&nbsp;`) recognized by this converter.
  List<String> get keys;

  /// The length of the longest key in [keys]. Used to optimize parsing.
  int get maxKeyLength;

  /// The list of values (such as `±`). This list has the same length as
  /// [keys], and strings in it correspond to the strings in [keys]
  /// at the same index.
  List<String> get values;

  /// Converts from HTML-escaped [data] to unescaped string.
  @override
  String convert(String data) {
    // Return early if possible.
    if (!data.contains('&')) return data;

    final buf = StringBuffer();
    var offset = 0;

    while (true) {
      final nextAmp = data.indexOf('&', offset);
      if (nextAmp == -1) {
        // Rest of string.
        buf.write(data.substring(offset));
        break;
      }
      buf.write(data.substring(offset, nextAmp));
      offset = nextAmp;

      final chunk =
          data.substring(offset, min(data.length, offset + _chunkLength));

      // Try &#123; and &#xff;
      if (chunk.length > _minDecimalEscapeLength &&
          chunk.codeUnitAt(1) == _hashCodeUnit) {
        final nextSemicolon = chunk.indexOf(';');
        if (nextSemicolon != -1) {
          final hex = chunk.codeUnitAt(2) == _xCodeUnit;
          final str = chunk.substring(hex ? 3 : 2, nextSemicolon);
          final ord = int.tryParse(str, radix: hex ? 16 : 10) ?? -1;
          if (ord != -1) {
            buf.write(String.fromCharCode(ord));
            offset += nextSemicolon + 1;
            continue;
          }
        }
      }

      // Try &nbsp;
      var replaced = false;
      for (var i = 0; i < keys.length; i++) {
        final key = keys[i];
        if (chunk.startsWith(key)) {
          final replacement = values[i];
          buf.write(replacement);
          offset += key.length;
          replaced = true;
          break;
        }
      }
      if (!replaced) {
        buf.write('&');
        offset += 1;
      }
    }

    return buf.toString();
  }

  @override
  StringConversionSink startChunkedConversion(Sink<String> sink) {
    Sink<String> modifiedSink = sink;
    if (modifiedSink is! StringConversionSink) {
      modifiedSink = StringConversionSink.from(sink);
    }
    return _HtmlUnescapeSink(modifiedSink, this);
  }
}

class _HtmlUnescapeSink extends StringConversionSinkBase {
  _HtmlUnescapeSink(this._sink, this._unescape);

  final StringConversionSink _sink;
  final HtmlUnescapeBase _unescape;

  /// The carry-over from the previous chunk.
  ///
  /// If the previous slice ended with ampersand too close to end,
  /// then the next slice may continue the reference.
  String? _carry;

  @override
  void addSlice(String chunk, int start, int end, bool isLast) {
    int modifiedEnd = end;
    int modifiedStart = start;
    String modifiedChunk = chunk;

    modifiedEnd = RangeError.checkValidRange(
      modifiedStart,
      modifiedEnd,
      modifiedChunk.length,
    );
    // If the chunk is empty, it's probably because it's the last one.
    // Handle that here, so we know the range is non-empty below.
    if (modifiedStart >= modifiedEnd) {
      if (isLast) close();
      return;
    }
    if (_carry != null) {
      modifiedChunk =
          _carry! + modifiedChunk.substring(modifiedStart, modifiedEnd);
      modifiedStart = 0;
      modifiedEnd = modifiedChunk.length;
      _carry = null;
    }
    _convert(modifiedChunk, modifiedStart, modifiedEnd, isLast);
    if (isLast) close();
  }

  @override
  void close() {
    if (_carry != null) {
      _sink.add(_unescape.convert(_carry!));
      _carry = null;
    }
    _sink.close();
  }

  void _convert(String chunk, int start, int end, bool isLast) {
    int modifiedStart = start;
    var nextAmp = chunk.indexOf('&', modifiedStart);
    if (nextAmp == -1 || nextAmp > end) {
      _sink.add(chunk.substring(modifiedStart, end));
      _carry = null;
      return;
    }

    while (nextAmp + _unescape.maxKeyLength <= end) {
      final lastAmp = chunk.lastIndexOf('&', end);
      final subEnd = lastAmp != -1 ? lastAmp : nextAmp + _unescape.maxKeyLength;
      final result = _unescape.convert(chunk.substring(modifiedStart, subEnd));
      _sink.add(result);
      modifiedStart = subEnd;
      nextAmp = chunk.indexOf('&', modifiedStart);
      if (nextAmp == -1 || nextAmp > end) {
        _sink.add(chunk.substring(modifiedStart, end));
        _carry = null;
        return;
      }
    }

    if (nextAmp + _unescape.maxKeyLength > end && isLast) {
      final result = _unescape.convert(chunk.substring(modifiedStart, end));
      _sink.add(result);
      _carry = null;
      return;
    }

    final nextCarry = chunk.substring(modifiedStart, end);
    if (_carry == null) {
      _carry = nextCarry;
    } else {
      _carry = _carry! + nextCarry;
    }
  }
}
