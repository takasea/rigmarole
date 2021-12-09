class ListData {
  final List<int> list;
  final int _addListNumber;

  ListData({
    int defaultLength = 1,
    int addListNumber = 5,
  })  : list = List<int>.generate(defaultLength, (index) => index + 1),
        _addListNumber = addListNumber;

  Future<void> getData() async {
    await Future.delayed(const Duration(seconds: 1), () {
      final int base = list.length;

      for (int i = 1; i < _addListNumber + 1; i++) {
        list.add(base + i);
      }
    }).timeout(
      const Duration(seconds: 2),
      onTimeout: () async {
        print('timeout!');
        await getData();
      },
    );
    //TODO: CountData error
  }
}
