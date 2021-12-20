import 'package:flutter/foundation.dart' show debugPrint;

import 'package:shared_preferences/shared_preferences.dart';

import 'pomodorodata.dart';

class ProjectData {
  ProjectData({
    required this.title,
    required this.pomodori,
    this.randomFlag = false,
  })  : startProject = DateTime.now().toUtc().toString(),
        pomodoroCount = 0,
        assert(title.isNotEmpty && title.length < 15);

  ProjectData.fromData({
    required this.startProject,
    required this.title,
    required this.pomodori,
    required this.pomodoroCount,
    required this.randomFlag,
  })  : assert(DateTime.parse(startProject).isUtc),
        assert(title.length < 15);

  final String startProject; // DateTime.parse(startProject)
  final String title;
  final List<PomodoroData> pomodori;
  int pomodoroCount;
  bool randomFlag;
}

List<String> projectNamesInitialize(SharedPreferences sharedPreferences) {
  return sharedPreferences.getStringList('projectNames') ?? [];
}

String readProjectName({
  required SharedPreferences sharedPreferences,
  required int projectIndex,
}) {
  final List<String> projects =
      sharedPreferences.getStringList('projectNames') ?? ['nothing'];

  return projects[projectIndex];
}

ProjectData readProjectDataFromSharedPreferences({
  required String projectName,
  required int projectNameIndex,
  required SharedPreferences sharedPreferences,
}) {
  final int index = projectNameIndex + 1;

  assert(
    sharedPreferences.containsKey(
        projectName + '-' + index.toString() + '-' + 'startProject'),
    'readProjectDataFromSharedPreferences: Key value \'' +
        projectName +
        '-' +
        index.toString() +
        '-' +
        'startProject' +
        '\' does not contain SharedPreferences.',
  );

  final ProjectData data = ProjectData.fromData(
    title: projectName,
    startProject: sharedPreferences.getString(
            projectName + '-' + index.toString() + '-' + 'startProject') ??
        '',
    pomodoroCount: sharedPreferences.getInt(
            projectName + '-' + index.toString() + '-' + 'pomodoroCount') ??
        -1,
    pomodori: [],
    randomFlag: sharedPreferences.getBool(
            projectName + '-' + index.toString() + '-' + 'randomFlag') ??
        false,
  );
  assert(data.pomodoroCount != -1);
  assert(data.startProject.isNotEmpty);

  bool _devPrint() {
    debugPrint('readProjectDataFromSharedPreferences : ' +
        projectName +
        '-' +
        index.toString() +
        '-');
    return true;
  }

  assert(_devPrint());

  return data;
}

//TODO: add error handling
Future<bool> addProjectDataInSharedPreferences(
    {required String title,
    required SharedPreferences sharedPreferences}) async {
  //add project name in SharedPreferences
  final List<String> projectNames =
      sharedPreferences.getStringList('projectNames') ?? [];

  projectNames.add(title);

  await sharedPreferences.setStringList('projectNames', projectNames);

  final ProjectData project = ProjectData(title: title, pomodori: []);

  // add ProjectData in SharedPreferences
  //
  // Even if they have the same project name,
  // they will not be mixed because of the position of the list.
  await sharedPreferences.setString(
      title + '-' + projectNames.length.toString() + '-' + 'startProject',
      project.startProject);

  await sharedPreferences.setBool(
      title + '-' + projectNames.length.toString() + '-' + 'randomFlag',
      project.randomFlag);
  await sharedPreferences.setInt(
      title + '-' + projectNames.length.toString() + '-' + 'pomodoroCount',
      project.pomodoroCount);
  assert(['1'].length == 1);

  bool _devPrint() {
    debugPrint('addProjectDataInSharedPreferences : ' +
        title +
        '-' +
        projectNames.length.toString() +
        '-');
    return true;
  }

  assert(_devPrint());

  return true;
}
