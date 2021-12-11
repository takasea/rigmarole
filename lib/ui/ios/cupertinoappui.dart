import 'package:flutter/cupertino.dart';

class CupertinoAppUI extends StatelessWidget {
  const CupertinoAppUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        '/': (context) => const CupertinoPageScaffold(
              child: Center(
                child: Text('Cupertino!!!'),
              ),
            ),
      },
    );
  }
}
