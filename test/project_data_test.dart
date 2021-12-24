import 'package:flutter_test/flutter_test.dart';
import 'package:rigmarole/model/pomodorodata.dart';
import 'package:rigmarole/model/projectdata.dart';

void main() {
  test('ProjectData contains data', () {
    final List<ProjectData> projects = [];

    //add another project
    projects.add(ProjectData(
      projectName: 'one',
      pomodori: [],
    ));

    //add pomodoro in project
    projects[0].pomodori.add(
          PomodoroData(
            what: 'one what 1',
            mean: 'one mean 1',
          ),
        );

    expect(projects[0].projectName, 'one');
    expect(projects[0].pomodori[0].what, 'one what 1');
    expect(projects[0].pomodori[0].mean, 'one mean 1');

    // same thing
    for (ProjectData project in projects) {
      expect(project.projectName, 'one');
      // print(project.title);
      for (PomodoroData pomodoro in project.pomodori) {
        expect(DateTime.parse(pomodoro.date).isUtc, true);
        expect(pomodoro.what, 'one what 1');
        expect(pomodoro.mean, 'one mean 1');

        // print('   ' + pomodoro.date + ' : ' + pomodoro.what + ' : ' + pomodoro.mean);
      }
    }
  });

  //TODO: ProjectData from manual input test
  test('ProjectData from manual input', () {});
}
