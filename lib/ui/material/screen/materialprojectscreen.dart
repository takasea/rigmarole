import 'package:flutter/material.dart';
import 'package:rigmarole/main.dart' show AppState;
import 'package:rigmarole/ui/material/screen/materialstepperscreen.dart';

class MaterialProjectScreen extends StatelessWidget {
  const MaterialProjectScreen({Key? key}) : super(key: key);
  static const String name = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //TODO: CommunicationWithBearWidget
          Flexible(
            flex: 2,
            child: Container(
              child: const Center(
                child: Text('bear!!!'),
              ),
              color: const Color(0xFFFFB560),
            ),
          ),
          //TODO: Round Corner
          const Flexible(
            flex: 1,
            child: ProjectListWidget(
              key:
                  GlobalObjectKey<_ProjectListWidgetState>('ProjectListWidget'),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          AddProjectButton(),
          SizedBox(
            height: 20,
          ),
          RandomChoiceButton(),
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: AppState.draw.projectNames.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppState.draw.projectNames[index],
              style: const TextStyle(fontSize: 20),
            ),
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
    setState(() {});
  }
}

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(
        Icons.playlist_add,
        size: 60,
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
      child: const Icon(
        Icons.casino,
        size: 60,
      ),
      onTap: () {
        print('random choice project!!!');
      },
    );
  }
}
