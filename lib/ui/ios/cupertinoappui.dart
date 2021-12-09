import 'package:flutter/cupertino.dart';
import 'screen/cupertinosomescreen.dart';
import 'screen/cupertinosecondscreen.dart';

class CupertinoAppUI extends StatelessWidget {
  const CupertinoAppUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        CupertinoSomeScreen.name: (context) =>
            const CupertinoSomeScreen(title: 'some screen'),
        CupertinoSecondScreen.name: (context) => const CupertinoSecondScreen(),
      },
    );
  }
}
