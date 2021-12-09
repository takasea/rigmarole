import 'package:flutter/material.dart';
import '../../utilities/selectuiplatform.dart';

class SomeWidget extends StatelessWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectPlatformUI(
      platformIOS:
          Container(width: 100, height: 100, color: Colors.lightBlueAccent),
      platformWeb: Container(width: 20, height: 20, color: Colors.red),
      defaultUI: Container(width: 20, height: 20, color: Colors.black),
    );
  }
}
