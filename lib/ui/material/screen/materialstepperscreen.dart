import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rigmarole/main.dart' show AppState;

import 'package:rigmarole/ui/material/screen/materialpomodoroscreen.dart';
import 'package:rigmarole/ui/material/screen/materialprojectscreen.dart';
import 'package:rigmarole/ui/section/screenbackbutton.dart';

class MaterialStepperScreen extends StatelessWidget {
  const MaterialStepperScreen({Key? key}) : super(key: key);
  static const String name = '/materialstepper';

  @override
  Widget build(BuildContext context) {
    final int projectIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 255),
      body: Column(
        children: [
          ProjectTitleSection(title: AppState.draw.projectNames[projectIndex]),
          const Flexible(
            child: PomodoroList(),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const ScreenBackButton(backScreenName: MaterialProjectScreen.name),
          const SizedBox(width: 20),
          AddPomodoroButton(projectIndex: projectIndex),
        ],
      ),
    );
  }
}

class ProjectTitleSection extends StatelessWidget {
  const ProjectTitleSection({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class PomodoroList extends StatefulWidget {
  const PomodoroList({Key? key}) : super(key: key);

  @override
  _PomodoroListState createState() => _PomodoroListState();
}

class _PomodoroListState extends State<PomodoroList> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _controller,
        itemCount: AppState.draw.project.pomodoroCount + 1,
        itemBuilder: (BuildContext context, int i) {
          if (i == AppState.draw.project.pomodoroCount) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              _controller.jumpTo(_controller.position.maxScrollExtent);
            });
            return const SizedBox(height: 300);
          } else {
            return PomodoroTile(
              what: AppState.draw.project.pomodori[i].what,
              mean: AppState.draw.project.pomodori[i].mean,
            );
          }
        });
  }
}

class PomodoroTile extends StatefulWidget {
  const PomodoroTile({Key? key, required this.what, required this.mean})
      : super(key: key);
  final String what;
  final String mean;

  @override
  State<PomodoroTile> createState() => _PomodoroTileState();
}

class _PomodoroTileState extends State<PomodoroTile> {
  bool openFlag = false;
  late String text;
  late Color color;

  final math.Random random = math.Random.secure();

  @override
  void initState() {
    super.initState();
    text = widget.what;
    color = Color.fromARGB(
      0,
      255 - random.nextInt(128),
      255 - random.nextInt(128),
      255,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          openFlag = !openFlag;
          if (openFlag) {
            text = widget.mean;
            color = Colors.yellow;
          } else {
            text = widget.what;
            color = Color.fromARGB(
              0,
              255 - random.nextInt(128),
              255 - random.nextInt(128),
              255,
            ); //.withOpacity(0.5);
          }
        });
      },
      child: AnimatedContainer(
        margin: openFlag == false
            ? const EdgeInsets.fromLTRB(20, 10, 20, 10)
            : const EdgeInsets.fromLTRB(20, 50, 20, 50),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withOpacity(0.5),
          borderRadius: BorderRadius.circular(openFlag == false ? 20 : 50),
          boxShadow: <BoxShadow>[
            const BoxShadow(
              color: Colors.black38,
              offset: Offset(1.8, 1.8),
              blurRadius: 0.8,
              spreadRadius: 0.3,
              blurStyle: BlurStyle.normal,
            ),
            BoxShadow(
              color: color.withAlpha(200),
              offset: const Offset(0.3, 0.0),
              blurRadius: 1.3,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.fromLTRB(
          30,
          openFlag == false ? 20 : 80,
          30,
          openFlag == false ? 20 : 80,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class AddPomodoroButton extends StatelessWidget {
  const AddPomodoroButton({Key? key, required this.projectIndex})
      : super(key: key);
  final int projectIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 150, 150, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0, 0),
              blurRadius: 4.0,
              spreadRadius: 0.3,
              blurStyle: BlurStyle.outer,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 230, 230, 255),
              offset: Offset(0.3, 0.0),
              blurRadius: 1.3,
              spreadRadius: 1.0,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 60,
        ),
      ),
      onTap: () {
        AppState.draw.addPomodoro(
          projectIndex: projectIndex,
          what: 'what',
          mean:
              'mean:asdfadsfadfasdfasdfasdfasdfasdfadsfasdfasdfadsfadsfadfadfaasdfadfadfaasdfadfa',
        );
        Navigator.pushReplacementNamed(context, MaterialPomodoroScreen.name);
      },
    );
  }
}
