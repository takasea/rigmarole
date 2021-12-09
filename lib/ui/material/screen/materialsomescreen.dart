import 'package:flutter/material.dart';
import '/main.dart' show AppState;
import 'materialsecondscreen.dart';
import '/ui/section/somewidget.dart';

class MaterialSomeScreen extends StatelessWidget {
  const MaterialSomeScreen({Key? key, required this.title}) : super(key: key);
  static const String name = '/';
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: const Text(
                'Push this text!',
              ),
              onTap: () {
                Navigator.pushNamed(context, MaterialSecondScreen.name);
              },
            ),
            const SomeWidget(),
            ValueListenableBuilder<int>(
              // valueListenable:
              //     GlobalObjectKey<AppState>('state').currentState!.counter,
              valueListenable: AppState.draw.counter,
              builder: (context, int counter, child) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          AppState.draw.counter.value++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
