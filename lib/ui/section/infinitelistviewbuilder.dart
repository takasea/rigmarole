import 'package:flutter/foundation.dart' show AsyncCallback;
import 'package:flutter/widgets.dart';

class InfiniteListViewBuilder<T> extends StatefulWidget {
  const InfiniteListViewBuilder({
    Key? key,
    required this.list,
    required this.addData,
    required this.listItem,
  })  : assert(list.length > 0),
        super(key: key);
  final AsyncCallback addData;
  final List<T> list;
  final Widget Function(List<T> list, int index) listItem;
  @override
  _InfiniteListViewBuilderState createState() =>
      _InfiniteListViewBuilderState<T>();
}

class _InfiniteListViewBuilderState<T>
    extends State<InfiniteListViewBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.list.length - 1) {
          widget.addData().then((_) {
            setState(() {});
          });
        }
        return widget.listItem(widget.list, index);
      },
    );
  }
}
