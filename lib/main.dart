import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/projectdata.dart';
import 'model/pomodorodata.dart';

import 'utilities/selectuiplatform.dart';
import 'ui/material/materialappui.dart';
// import 'ui/ios/cupertinoappui.dart';

void main() async {
  // debugPrintBeginFrameBanner = true;
  // debugPrintRebuildDirtyWidgets = true;

  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final List<String> projectNames = projectNamesInitialize(sharedPreferences);

  runApp(
    App(
      key: const GlobalObjectKey<AppState>('state'),
      sharedPreferences: sharedPreferences,
      projectNames: projectNames,
    ),
  );
}

class App extends StatefulWidget {
  const App({
    required key,
    required this.sharedPreferences,
    required this.projectNames,
  }) : super(key: key);
  final SharedPreferences sharedPreferences;
  final List<String> projectNames;
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  late final SharedPreferences sharedPreferences;
  late final List<String> projectNames;

  ProjectData project = ProjectData(title: 'init', pomodori: []);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    sharedPreferences = widget.sharedPreferences;
    projectNames = widget.projectNames;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SelectPlatformUI(
      // platformIOS: CupertinoAppUI(),
      defaultUI: MaterialAppUI(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //TODO: app lifecycle
  }

  static AppState get draw {
    return const GlobalObjectKey<AppState>('state').currentState!;
  }

  void addProject(String title) async {
    projectNames.add(title);

    await addProjectDataInSharedPreferences(
      title: title,
      sharedPreferences: sharedPreferences,
    );
  }

  void readProjectData(String projectName) {
    project = readProjectDataFromSharedPreferences(
      projectName: projectName,
      projectNameIndex: projectNames.indexOf(projectName),
      sharedPreferences: sharedPreferences,
    );

    bool _devPrint() {
      debugPrint('---readProjectData---');
      debugPrint('---project---');
      debugPrint('title : ' + project.title);

      debugPrint(DateTime.parse(project.startProject).toString());
      debugPrint('pomodoroCount :' + project.pomodoroCount.toString());
      debugPrint('randomFlag : ' + project.randomFlag.toString());
      debugPrint('------------');
      return true;
    }

    assert(_devPrint());

    for (int i = 0; i < project.pomodoroCount; i++) {
      project.pomodori.add(_readPomodoroData(
        projectIndex: projectNames.indexOf(projectName),
        pomodoroIndex: i,
      ));
    }
  }

  PomodoroData _readPomodoroData({
    required int projectIndex,
    required int pomodoroIndex,
  }) {
    final data = readPomodoroDataFromSharedPreferences(
      sharedPreferences: sharedPreferences,
      projectIndex: projectIndex,
      pomodoroIndex: pomodoroIndex,
    );

    bool _devPrint() {
      debugPrint('------Pomodoro-------');
      debugPrint(DateTime.parse(data.date).toString());
      debugPrint('what : ' + data.what);
      debugPrint('mean : ' + data.mean);
      debugPrint('markerFlag' + data.markerFlag.toString());
      return true;
    }

    assert(_devPrint());

    return data;
  }

  void addPomodoro(
      {required int projectIndex,
      required String what,
      required String mean}) async {
    //TODO: add error handling
    await addPomodoroDataInSharedPreferences(
      projectIndex: projectIndex,
      sharedPreferences: sharedPreferences,
      what: what,
      mean: mean,
    );
  }
}
