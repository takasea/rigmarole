import 'package:flutter/material.dart';
import '/../../main.dart' show AppState;
import '../../section/infinitelistviewbuilder.dart';

class MaterialSecondScreen extends StatelessWidget {
  const MaterialSecondScreen({Key? key}) : super(key: key);
  static const String name = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('second screen'),
      ),
      body: InfiniteListViewBuilder(
        list: AppState.draw.listData.list,
        addData: AppState.draw.listData.getData,
        listItem: (List<Object> list, int index) {
          return Center(
            child: Text(
              list[index].toString(),
              style: const TextStyle(fontSize: 80),
            ),
          );
        },
      ),
    );
  }
}
