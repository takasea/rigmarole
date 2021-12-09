import 'package:flutter/cupertino.dart';
import '/../../main.dart' show AppState;
import '/ui/section/infinitelistviewbuilder.dart';

class CupertinoSecondScreen extends StatelessWidget {
  const CupertinoSecondScreen({Key? key}) : super(key: key);
  static const String name = '/second';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('second screen'),
      ),
      child: InfiniteListViewBuilder(
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
