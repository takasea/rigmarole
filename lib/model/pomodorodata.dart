import 'package:flutter/foundation.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart';

import 'projectdata.dart';

class PomodoroData {
  PomodoroData({
    required this.what,
    required this.mean,
    this.markerFlag = false,
  })  : date = DateTime.now().toUtc().toString(),
        assert(what.length > 1 && what.length < 15),
        assert(mean.length > 1 && mean.length < 140);

  PomodoroData.fromData({
    required this.date,
    required this.what,
    required this.mean,
    required this.markerFlag,
  })  : assert(DateTime.parse(date).isUtc),
        assert(what.length > 1 && what.length < 15),
        assert(mean.length > 1 && mean.length < 140);

  final String date; // DateTime.parse(date)
  final String what;
  final String mean;
  bool markerFlag;
}

PomodoroData readPomodoroDataFromSharedPreferences({
  required SharedPreferences sharedPreferences,
  required int projectIndex,
  required int pomodoroIndex,
}) {
  final String projectName = readProjectName(
    sharedPreferences: sharedPreferences,
    projectIndex: projectIndex,
  );

  projectIndex++;
  pomodoroIndex++;

  assert(
    sharedPreferences.containsKey(projectName +
        '-' +
        projectIndex.toString() +
        '-' +
        'Pomodoro' +
        '-' +
        pomodoroIndex.toString() +
        '-' +
        'date'),
    'readPomodoroDataFromSharedPreferences: Key value \'' +
        projectName +
        '-' +
        projectIndex.toString() +
        '-' +
        'Pomodoro' +
        '-' +
        pomodoroIndex.toString() +
        '-' +
        'date' +
        '\' does not contain SharedPreferences.',
  );

  final data = PomodoroData.fromData(
    date: sharedPreferences.getString(projectName +
            '-' +
            projectIndex.toString() +
            '-' +
            'Pomodoro' +
            '-' +
            pomodoroIndex.toString() +
            '-' +
            'date') ??
        '',
    what: sharedPreferences.getString(projectName +
            '-' +
            projectIndex.toString() +
            '-' +
            'Pomodoro' +
            '-' +
            pomodoroIndex.toString() +
            '-' +
            'what') ??
        'oh my god!!!',
    mean: sharedPreferences.getString(projectName +
            '-' +
            projectIndex.toString() +
            '-' +
            'Pomodoro' +
            '-' +
            pomodoroIndex.toString() +
            '-' +
            'mean') ??
        '',
    markerFlag: sharedPreferences.getBool(projectName +
            '-' +
            projectIndex.toString() +
            '-' +
            'Pomodoro' +
            '-' +
            pomodoroIndex.toString() +
            '-' +
            'makerFlag') ??
        false,
  );

  bool _devPrint() {
    debugPrint('readPomodoroDataFromSharedPreferences : ' +
        projectName +
        '-' +
        projectIndex.toString() +
        '-' +
        'Pomodoro' +
        '-' +
        pomodoroIndex.toString() +
        '-');
    return true;
  }

  assert(_devPrint());

  return data;
}

//TODO: error handling
Future<bool> addPomodoroDataInSharedPreferences({
  required SharedPreferences sharedPreferences,
  required int projectIndex,
  required String what,
  required String mean,
}) async {
  final String projectName = readProjectName(
    sharedPreferences: sharedPreferences,
    projectIndex: projectIndex,
  );

  projectIndex++;

  int pomodoroCount = sharedPreferences.getInt(projectName +
          '-' +
          projectIndex.toString() +
          '-' +
          'pomodoroCount') ??
      0;

  pomodoroCount++;

  await sharedPreferences.setInt(
      projectName + '-' + projectIndex.toString() + '-' + 'pomodoroCount',
      pomodoroCount);

  //add data
  final PomodoroData data = PomodoroData(what: what, mean: mean);

  await sharedPreferences.setString(
      projectName +
          '-' +
          projectIndex.toString() +
          '-' +
          'Pomodoro' +
          '-' +
          pomodoroCount.toString() +
          '-' +
          'date',
      data.date);

  await sharedPreferences.setString(
      projectName +
          '-' +
          projectIndex.toString() +
          '-' +
          'Pomodoro' +
          '-' +
          pomodoroCount.toString() +
          '-' +
          'what',
      data.what);

  await sharedPreferences.setString(
      projectName +
          '-' +
          projectIndex.toString() +
          '-' +
          'Pomodoro' +
          '-' +
          pomodoroCount.toString() +
          '-' +
          'mean',
      data.mean);

  await sharedPreferences.setBool(
      projectName +
          '-' +
          projectIndex.toString() +
          '-' +
          'Pomodoro' +
          '-' +
          pomodoroCount.toString() +
          '-' +
          'markerFlag',
      data.markerFlag);

  bool _devPrint() {
    debugPrint('addPomodoroDataInSharedPreferences : ' +
        projectName +
        '-' +
        projectIndex.toString() +
        '-' +
        'Pomodoro' +
        '-' +
        pomodoroCount.toString() +
        '-');
    return true;
  }

  assert(_devPrint());

  return true;
}
