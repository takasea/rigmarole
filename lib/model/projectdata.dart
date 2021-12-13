import 'pomodorodata.dart';

class ProjectData {
  ProjectData({
    required this.title,
    required this.pomodori,
    this.randomFlag = false,
  })  : startProject = DateTime.now().toUtc().toString(),
        assert(title.isNotEmpty && title.length < 15);

  ProjectData.fromData({
    required this.startProject,
    required this.title,
    required this.pomodori,
    required this.randomFlag,
  })  : assert(DateTime.parse(startProject).isUtc),
        assert(title.length < 15);

  final String startProject; // DateTime.parse(startProject)
  final String title;
  final List<PomodoroData> pomodori;
  bool randomFlag;

  void getDataFromDB() {
    //TODO:
  }
}
