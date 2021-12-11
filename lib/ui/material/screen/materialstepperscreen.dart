import 'package:flutter/material.dart';

import 'package:rigmarole/ui/material/screen/materialpomodoroscreen.dart';
import 'package:rigmarole/ui/material/screen/materialprojectscreen.dart';
import 'package:rigmarole/ui/section/screenbackbutton.dart';

class MaterialStepperScreen extends StatelessWidget {
  const MaterialStepperScreen({Key? key}) : super(key: key);
  static const String name = '/materialstepper';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Flexible(
            flex: 1,
            child: StepperSection(),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          ScreenBackButton(backScreenName: MaterialProjectScreen.name),
          SizedBox(width: 60),
        ],
      ),
    );
  }
}

class StepperSection extends StatefulWidget {
  const StepperSection({Key? key}) : super(key: key);

  @override
  _StepperSectionState createState() => _StepperSectionState();
}

class _StepperSectionState extends State<StepperSection> {
  int _index = 1;
  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
        Navigator.pushReplacementNamed(context, MaterialPomodoroScreen.name);
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
          //TODO: change text color
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}
