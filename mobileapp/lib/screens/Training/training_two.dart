import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/screens/Training/training_four.dart';
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
  @override
  Widget build(BuildContext context) {
    final muscle = ModalRoute.of(context)!.settings.arguments as Muscle;

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Order of the exercise:'),
                        Text('1'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Set Number:'),
                        Text('1'),
                      ],
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
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(TrainingThree.routeName);
                      },
                      child: Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(TrainingThree.routeName);
                          },
                          child: Text(
                            'End Training',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(TraningFinish.routeName);
                          },
                          child: Text(
                            'Report Injury',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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
