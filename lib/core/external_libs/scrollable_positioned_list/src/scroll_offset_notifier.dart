import 'dart:async';

import 'package:quran_majeed/core/external_libs/scrollable_positioned_list/src/scroll_offset_listener.dart';

class ScrollOffsetNotifier implements ScrollOffsetListener {
  ScrollOffsetNotifier({this.recordProgrammaticScrolls = true});
  final bool recordProgrammaticScrolls;

  final _streamController = StreamController<double>();

  @override
  Stream<double> get changes => _streamController.stream;

  StreamController<double> get changeController => _streamController;

  void dispose() {
    _streamController.close();
  }
}
