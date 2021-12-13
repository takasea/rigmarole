import 'package:flutter/material.dart';

import 'model/projectdata.dart';

import 'utilities/selectuiplatform.dart';
import 'ui/material/materialappui.dart';
import 'ui/ios/cupertinoappui.dart';

void main() {
  // debugPrintBeginFrameBanner = true;
  // debugPrintRebuildDirtyWidgets = true;

  // const app = App(key: GlobalObjectKey<AppState>('state'), projects: []);
  // app.projects.addAll(dummyData);
  // runApp(app);

  //TODO: get DB data

  runApp(
    App(
      key: const GlobalObjectKey<AppState>('state'),
      projects: dummyData,
    ),
  );
}

class App extends StatefulWidget {
  const App({required key, required this.projects}) : super(key: key);
  final List<ProjectData> projects;
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  late final List<ProjectData> projects;

  //TODO : add other state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    projects = widget.projects;
  }

  @override
  void dispose() {
    counter.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SelectPlatformUI(
      platformIOS: CupertinoAppUI(),
      defaultUI: MaterialAppUI(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //TODO: app lifecycle
    print('App lifecycle: $state');
  }

  static AppState get draw {
    return const GlobalObjectKey<AppState>('state').currentState!;
  }
}
