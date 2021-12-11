import 'package:flutter/material.dart';

class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({Key? key, required this.backScreenName})
      : super(key: key);
  final String backScreenName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(
        Icons.arrow_back,
        size: 60,
      ),
      //TODO: back button design
      //arrow_back
      //arrow_back_ios_new
      //extension_sharp
      onTap: () {
        Navigator.pushReplacementNamed(context, backScreenName);
      },
    );
  }
}
