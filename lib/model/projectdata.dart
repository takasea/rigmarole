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

List<ProjectData> dummyData = [
  ProjectData(
    title: 'One',
    pomodori: [
      PomodoroData(
        what: 'what One 1',
        mean: 'mean One 1',
      ),
      PomodoroData(
        what: 'what One 2',
        mean: 'mean One 2',
      ),
      PomodoroData(
        what: 'what One 3',
        mean: 'mean One 3',
      ),
    ],
  ),
  ProjectData(
    title: 'Two',
    pomodori: [
      PomodoroData(
        what: 'what Two 1',
        mean: 'mean Two 1',
      ),
    ],
  ),
  ProjectData(title: 'Three', pomodori: []),
  ProjectData(title: 'Four', pomodori: []),
  ProjectData(title: 'Five', pomodori: []),
  ProjectData(title: 'Six', pomodori: []),
  ProjectData(title: 'Seven', pomodori: []),
];
