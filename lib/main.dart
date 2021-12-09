import 'package:flutter/material.dart';

import 'model/countdata.dart';

import 'utilities/selectuiplatform.dart';
import 'ui/material/materialappui.dart';
import 'ui/ios/cupertinoappui.dart';

void main() {
  // debugPrintBeginFrameBanner = true;
  // debugPrintRebuildDirtyWidgets = true;
  runApp(
    const App(
      key: GlobalObjectKey<AppState>('state'),
    ),
  );
}

class App extends StatefulWidget {
  const App({required key}) : super(key: key);
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  final ListData listData = ListData();

  //TODO : add other state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
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
