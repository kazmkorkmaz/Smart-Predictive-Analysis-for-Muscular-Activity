import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/Training/training_one.dart';
import 'package:mobileapp/screens/Training/training_three.dart';

class TrainingInfo extends StatefulWidget {
  static const routeName = '/TrainingInfo';

  @override
  State<TrainingInfo> createState() => _TrainingInfoState();
}

class _TrainingInfoState extends State<TrainingInfo> {
  String? statusOfTheUser;
  final statusValue = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  DropdownMenuItem<String> statusMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
  TextEditingController exercise = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController setNumber = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final muscle = ModalRoute.of(context)!.settings.arguments as Muscle;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Muscle Group'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              muscle.image,
                            ),
                          )),
                      SizedBox(height: 10),
                      Text(muscle.name),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: exercise,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Name of the exercise',
                          prefixIcon: Icon(FontAwesomeIcons.dumbbell),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: weight,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Weight',
                          prefixIcon: Icon(FontAwesomeIcons.weight),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: setNumber,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Set Number',
                          prefixIcon: Icon(FontAwesomeIcons.listNumeric),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status of the user for the training:'),
                        DropdownButton(
                          value: statusOfTheUser,
                          items: statusValue.map(statusMenuItem).toList(),
                          onChanged: (value) => setState(
                              () => this.statusOfTheUser = value as String),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          width * 0.5,
                          height * 0.06,
                        ),
                      ),
                      onPressed: () {
                        if (muscle.server != '' &&
                            exercise.text != '' &&
                            weight.text != '' &&
                            setNumber.text != '' &&
                            statusOfTheUser != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TrainingThree(
                                  server: muscle.server,
                                  muscle: muscle.name,
                                  muscleImage: muscle.image,
                                  exerciseName: exercise.text,
                                  weight: double.parse(weight.text),
                                  setNumber: int.parse(setNumber.text),
                                  statusOfUser: int.parse(
                                    statusOfTheUser.toString(),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          MyDialog dialog = MyDialog();
                          dialog.showErrorDialog(
                              'Some areas about training is null!', context);
                        }
                      },
                      child: Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
