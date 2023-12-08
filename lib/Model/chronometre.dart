import 'dart:async';

import 'package:evals7/helper/boxes.dart';
import 'package:hive/hive.dart';

class Chronometre {
  String formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String millisecondsStr =
        (milliseconds % 1000 ~/ 10).toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr.$millisecondsStr';
  }
}
