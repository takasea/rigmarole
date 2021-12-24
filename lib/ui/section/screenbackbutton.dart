import 'package:flutter/material.dart';

class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({Key? key, required this.backScreenName})
      : super(key: key);
  final String backScreenName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 180, 100),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0, 0),
              blurRadius: 4.0,
              spreadRadius: 0.3,
              blurStyle: BlurStyle.outer,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 230, 230, 255),
              offset: Offset(0.3, 0.0),
              blurRadius: 1.3,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 60,
          color: Color(0xFF505050),
        ),
      ),
      //arrow_back
      //arrow_back_ios_new
      //extension_sharp
      onTap: () {
        Navigator.pushReplacementNamed(context, backScreenName);
      },
    );
  }
}
