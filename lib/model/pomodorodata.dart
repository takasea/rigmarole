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

enum kPomodoroData {
  date,
  what,
  mean,
  makerFlag,
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

  String _getKey(String member) {
    return projectName +
        '-' +
        projectIndex.toString() +
        '-' +
        'Pomodoro' +
        '-' +
        pomodoroIndex.toString() +
        '-' +
        member;
  }

  assert(
    sharedPreferences.containsKey(_getKey(kPomodoroData.date.name)),
    'readPomodoroDataFromSharedPreferences: Key value \'' +
        _getKey(kPomodoroData.date.name) +
        '\' does not contain SharedPreferences.',
  );

  final data = PomodoroData.fromData(
    date: sharedPreferences.getString(_getKey(kPomodoroData.date.name)) ?? '',
    what: sharedPreferences.getString(_getKey(kPomodoroData.what.name)) ??
        'oh my god!!!',
    mean: sharedPreferences.getString(_getKey(kPomodoroData.mean.name)) ?? '',
    markerFlag:
        sharedPreferences.getBool(_getKey(kPomodoroData.makerFlag.name)) ??
            false,
  );

  bool _devPrint() {
    debugPrint('readPomodoroDataFromSharedPreferences : ' + _getKey('MEMBER'));
    return true;
  }

  // assert(_devPrint());

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

  final String _pomodoroCountKey = projectName +
      '-' +
      projectIndex.toString() +
      '-' +
      kProjectData.pomodoroCount.name;

  int pomodoroCount = sharedPreferences.getInt(_pomodoroCountKey) ?? 0;
  pomodoroCount++;
  await sharedPreferences.setInt(_pomodoroCountKey, pomodoroCount);

  //add data
  final PomodoroData data = PomodoroData(what: what, mean: mean);
  String _getKey(String member) {
    return projectName +
        '-' +
        projectIndex.toString() +
        '-' +
        'Pomodoro' +
        '-' +
        pomodoroCount.toString() +
        '-' +
        member;
  }

  await sharedPreferences.setString(
      _getKey(kPomodoroData.date.name), data.date);

  await sharedPreferences.setString(
      _getKey(kPomodoroData.what.name), data.what);

  await sharedPreferences.setString(
      _getKey(kPomodoroData.mean.name), data.mean);

  await sharedPreferences.setBool(
      _getKey(kPomodoroData.makerFlag.name), data.markerFlag);

  bool _devPrint() {
    debugPrint('addPomodoroDataInSharedPreferences : ' + _getKey('MEMBER'));
    return true;
  }

  // assert(_devPrint());

  return true;
}
