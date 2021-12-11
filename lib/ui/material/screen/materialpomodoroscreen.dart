import 'package:flutter/material.dart';
import 'package:rigmarole/ui/material/screen/materialprojectscreen.dart';
import 'package:rigmarole/ui/section/screenbackbutton.dart';

class MaterialPomodoroScreen extends StatelessWidget {
  const MaterialPomodoroScreen({Key? key}) : super(key: key);
  static const String name = '/materialpomodoro';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Timer!!!',
          style: TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton:
          ScreenBackButton(backScreenName: MaterialProjectScreen.name),
    );
  }
}
