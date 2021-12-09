import 'package:flutter/material.dart';
import 'screen/materialsomescreen.dart';
import 'screen/materialsecondscreen.dart';

class MaterialAppUI extends StatelessWidget {
  const MaterialAppUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MaterialSomeScreen.name: (context) =>
            const MaterialSomeScreen(title: 'some screen'),
        MaterialSecondScreen.name: (context) => const MaterialSecondScreen(),
      },
    );
  }
}
