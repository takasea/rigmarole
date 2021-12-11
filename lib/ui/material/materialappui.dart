import 'package:flutter/material.dart';

import 'screen/materialpomodoroscreen.dart';
import 'screen/materialprojectscreen.dart';
import 'screen/materialstepperscreen.dart';

class MaterialAppUI extends StatelessWidget {
  const MaterialAppUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MaterialProjectScreen.name: (context) => const MaterialProjectScreen(),
        MaterialStepperScreen.name: (context) => const MaterialStepperScreen(),
        MaterialPomodoroScreen.name: (context) =>
            const MaterialPomodoroScreen(),
      },
    );
  }
}
