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
          //TODO: ProjectListWidget
          //TODO: Round Corner
          Flexible(
            flex: 1,
            child: ListView.builder(
              itemCount: AppState.draw.projects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppState.draw.projects[index].title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      MaterialStepperScreen.name,
                      arguments: index,
                    );
                  },
                );
              },
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
        print('add project!!!');
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
