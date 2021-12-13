class PomodoroData {
  PomodoroData({
    required this.what,
    required this.mean,
    this.markerFlag = false,
  })  : date = DateTime.now().toUtc().toString(),
        assert(what.length > 1 && what.length < 15),
        assert(mean.length > 1 && mean.length < 140);

  PomodoroData.fromData({
    required this.date,
    required this.what,
    required this.mean,
    required this.markerFlag,
  })  : assert(DateTime.parse(date).isUtc),
        assert(what.length > 1 && what.length < 15),
        assert(mean.length > 1 && mean.length < 140);

  final String date; // DateTime.parse(date)
  final String what;
  final String mean;
  bool markerFlag;
}
