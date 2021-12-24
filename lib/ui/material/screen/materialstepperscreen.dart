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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 150),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Flexible(
            flex: 5,
            child: PomodoroList(),
          ),
          Flexible(
            flex: 1,
            child: StepperBottomSection(),
          ),
        ],
      ),
    );
  }
}

class StepperBottomSection extends StatelessWidget {
  const StepperBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(200, 200, 200, 200),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
        child: Row(
          children: const [
            ProjectTitle(),
            ScreenBackButton(backScreenName: MaterialProjectScreen.name),
            SizedBox(width: 20),
            AddPomodoroButton(),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}

class ProjectTitle extends StatelessWidget {
  const ProjectTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int projectIndex = ModalRoute.of(context)!.settings.arguments as int;
    final String title = AppState.draw.projectNames[projectIndex];
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              color: Color(0xFF505050),
              letterSpacing: 3,
              fontFamily: 'SpicyRice',
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Random',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF505050),
                    fontFamily: 'PressStart2P',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Switch.adaptive(value: true, onChanged: (flag) {})
              ],
            ),
          )
        ],
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
  bool _initialFlag = true;

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
            if (_initialFlag == true) {
              _initialFlag = false;
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                _controller.jumpTo(_controller.position.maxScrollExtent);
              });
            }
            return const SizedBox(height: 450);
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
  const PomodoroTile({
    Key? key,
    required this.what,
    required this.mean,
  }) : super(key: key);
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
    //TODO: add a meta message structure
    return GestureDetector(
      onTap: () {
        if (openFlag == false) {
          setState(() {
            openFlag = !openFlag;
            text = widget.mean;
            color = const Color(0xff9afff0);
          });
        } else {
          setState(() {
            openFlag = !openFlag;
            text = widget.what;
            color = Color.fromARGB(
              0,
              255 - random.nextInt(128),
              255 - random.nextInt(128),
              255,
            );
          });
        }
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
          style: openFlag == false
              ? const TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 20,
                  fontFamily: 'PressStart2P',
                )
              : const TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 30,
                  fontFamily: 'Dekko',
                ),
          strutStyle: openFlag == false
              ? const StrutStyle(
                  leading: 0.0,
                )
              : const StrutStyle(leading: 0.5),
        ),
      ),
    );
  }
}

class AddPomodoroButton extends StatelessWidget {
  const AddPomodoroButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int projectIndex = ModalRoute.of(context)!.settings.arguments as int;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 180, 100),
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
          Icons.add_task,
          size: 60,
          color: Color(0xFF505050),
        ),
      ),
      onTap: () {
        AppState.draw.addPomodoro(
          projectIndex: projectIndex,
          what: 'whatasdfad',
          mean:
              'mean:asdf adsfadf asdfa sdfasdfa sdfasdf. adsfasdfasdfadsfadsfadfadfaasdfadfadfaasdfadfa',
        );
        Navigator.pushReplacementNamed(context, MaterialPomodoroScreen.name);
      },
    );
  }
}
