import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rigmarole/main.dart' show AppState;
import 'package:rigmarole/ui/material/screen/materialstepperscreen.dart';

class MaterialProjectScreen extends StatelessWidget {
  const MaterialProjectScreen({Key? key}) : super(key: key);
  static const String name = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 150),
      body: Column(
        children: const [
          Flexible(
            flex: 2,
            //ReviewSection
            child: Center(
              child: Text('review!!!'),
            ),
          ),
          Flexible(
            flex: 1,
            child: ProjectBottomSection(),
          ),
        ],
      ),
    );
  }
}

class ProjectBottomSection extends StatelessWidget {
  const ProjectBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(200, 200, 200, 200),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const Flexible(
            flex: 4,
            child: ProjectListWidget(
              key:
                  GlobalObjectKey<_ProjectListWidgetState>('ProjectListWidget'),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                AddProjectButton(),
                SizedBox(
                  height: 20,
                ),
                RandomChoiceButton(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProjectListWidget extends StatefulWidget {
  const ProjectListWidget({required Key key}) : super(key: key);

  @override
  _ProjectListWidgetState createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  final math.Random random = math.Random.secure();

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: AppState.draw.projectNames.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ProjectTile(
            color: Color.fromARGB(
              0,
              255 - random.nextInt(128),
              255 - random.nextInt(128),
              255,
            ),
            name: AppState.draw.projectNames[index],
          ),
          onTap: () {
            AppState.draw.readProjectData(AppState.draw.projectNames[index]);

            Navigator.pushReplacementNamed(
              context,
              MaterialStepperScreen.name,
              arguments: index,
            );
          },
        );
      },
    );
  }

  void rebuildWidget() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
    setState(() {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
    });
  }
}

class ProjectTile extends StatelessWidget {
  const ProjectTile({Key? key, required this.name, required this.color})
      : super(key: key);
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: Color(0x40000000),
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
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'SpicyRice',
          color: Color(0xFF505050),
          letterSpacing: 3,
        ),
      ),
    );
  }
}

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Icons.playlist_add,
          size: 60,
          color: Color(0xFF505050),
        ),
      ),
      onTap: () {
        //TODO: add SnackBar or Dialogs
        final String title = 'NewProject' +
            (AppState.draw.projectNames.length + 1).toString() +
            '!';

        AppState.draw.addProject(title);
        const GlobalObjectKey<_ProjectListWidgetState>('ProjectListWidget')
            .currentState!
            .rebuildWidget();
      },
    );
  }
}

class RandomChoiceButton extends StatelessWidget {
  const RandomChoiceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Icons.casino,
          size: 60,
          color: Color(0xFF505050),
        ),
      ),
      onTap: () {
        print('random choice project!!!');
      },
    );
  }
}
