import 'package:flutter/foundation.dart' show AsyncCallback;
import 'package:flutter/widgets.dart';

class InfiniteListViewBuilder extends StatefulWidget {
  const InfiniteListViewBuilder({
    Key? key,
    required this.list,
    required this.addData,
    required this.listItem,
  })  : assert(list.length > 0),
        super(key: key);
  final AsyncCallback addData;
  final List<Object> list;
  final Widget Function(List<Object>, int index) listItem;
  @override
  _InfiniteListViewBuilderState createState() =>
      _InfiniteListViewBuilderState();
}

class _InfiniteListViewBuilderState extends State<InfiniteListViewBuilder> {
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
