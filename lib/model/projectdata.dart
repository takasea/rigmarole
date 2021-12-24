import 'package:flutter/foundation.dart' show debugPrint;

import 'package:shared_preferences/shared_preferences.dart';

import 'pomodorodata.dart';

class ProjectData {
  ProjectData({
    required this.projectName,
    required this.pomodori,
    this.randomFlag = true,
  })  : startProject = DateTime.now().toUtc().toString(),
        pomodoroCount = 0,
        assert(projectName.isNotEmpty && projectName.length < 15);

  ProjectData.fromData({
    required this.startProject,
    required this.projectName,
    required this.pomodori,
    required this.pomodoroCount,
    required this.randomFlag,
  })  : assert(DateTime.parse(startProject).isUtc),
        assert(projectName.length < 15);

  final String startProject; // DateTime.parse(startProject)
  final String projectName;
  final List<PomodoroData> pomodori;
  int pomodoroCount;
  bool randomFlag;
}

enum kProjects { projectNames }

enum kProjectData {
  startProject,
  projectName,
  pomodori,
  pomodoroCount,
  randomFlag,
}

List<String> projectNamesInitialize(SharedPreferences sharedPreferences) {
  return sharedPreferences.getStringList(kProjects.projectNames.name) ?? [];
}

String readProjectName({
  required SharedPreferences sharedPreferences,
  required int projectIndex,
}) {
  final List<String> projects =
      sharedPreferences.getStringList(kProjects.projectNames.name) ??
          ['nothing'];

  return projects[projectIndex];
}

ProjectData readProjectDataFromSharedPreferences({
  required String projectName,
  required int projectNameIndex,
  required SharedPreferences sharedPreferences,
}) {
  final int index = projectNameIndex + 1;

  String _getKey(String member) {
    return projectName + '-' + index.toString() + '-' + member;
  }

  assert(
    sharedPreferences.containsKey(_getKey(kProjectData.startProject.name)),
    'readProjectDataFromSharedPreferences: Key value \'' +
        _getKey(kProjectData.startProject.name) +
        '\' does not contain SharedPreferences.',
  );

  final ProjectData data = ProjectData.fromData(
    projectName: projectName,
    startProject:
        sharedPreferences.getString(_getKey(kProjectData.startProject.name)) ??
            '',
    pomodoroCount:
        sharedPreferences.getInt(_getKey(kProjectData.pomodoroCount.name)) ??
            -1,
    pomodori: [],
    randomFlag:
        sharedPreferences.getBool(_getKey(kProjectData.randomFlag.name)) ??
            false,
  );
  assert(data.pomodoroCount != -1);
  assert(data.startProject.isNotEmpty);

  bool _devPrint() {
    debugPrint('readProjectDataFromSharedPreferences : ' + _getKey('MEMBER'));
    return true;
  }
  // assert(_devPrint());

  return data;
}

//TODO: add error handling
Future<bool> addProjectDataInSharedPreferences(
    {required String title,
    required SharedPreferences sharedPreferences}) async {
  //add project name in SharedPreferences
  final List<String> projectNames =
      sharedPreferences.getStringList(kProjects.projectNames.name) ?? [];

  projectNames.add(title);

  await sharedPreferences.setStringList(
      kProjects.projectNames.name, projectNames);

  final ProjectData project = ProjectData(projectName: title, pomodori: []);

  // add ProjectData in SharedPreferences
  //
  // Even if they have the same project name,
  // they will not be mixed because of the position of the list.
  String _getKey(String member) {
    return title + '-' + projectNames.length.toString() + '-' + member;
  }

  await sharedPreferences.setString(
      _getKey(kProjectData.startProject.name), project.startProject);
  await sharedPreferences.setBool(
      _getKey(kProjectData.randomFlag.name), project.randomFlag);
  await sharedPreferences.setInt(
      _getKey(kProjectData.pomodoroCount.name), project.pomodoroCount);
  assert(['1'].length == 1);

  bool _devPrint() {
    debugPrint('addProjectDataInSharedPreferences : ' + _getKey('MEMBER'));
    return true;
  }
  // assert(_devPrint());

  return true;
}

void changeRandomFlagInSharedPreferences(
    {required SharedPreferences sharedPreferences,
    required String projectName}) async {
  final List<String> projectNames =
      sharedPreferences.getStringList(kProjects.projectNames.name) ?? [];

  final String _key = projectName +
      '-' +
      (projectNames.indexOf(projectName) + 1).toString() +
      '-' +
      kProjectData.randomFlag.name;

  final bool _current = sharedPreferences.getBool(_key) ?? true;

  bool _devPrint() {
    debugPrint('changeRandomFlagInSharedPreferences' + _key.toString());
    debugPrint('current:' + _current.toString());
    return true;
  }

  // assert(_devPrint());

  await sharedPreferences.setBool(_key, !_current);
}
