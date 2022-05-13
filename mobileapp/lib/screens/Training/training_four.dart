import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/screens/Training/training_five.dart';
import 'package:mobileapp/screens/Training/training_one.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TraningFinish extends StatefulWidget {
  static const routeName = '/TrainingFinish';

  final BluetoothDevice server;
  final String exerciseName;
  final String muscle;
  final String muscleImage;
  final double weight;
  final int setNumber;
  final int statusOfUser;
  final int duration;
  final List<double> datas;
  TraningFinish({
    required this.server,
    required this.exerciseName,
    required this.muscle,
    required this.muscleImage,
    required this.weight,
    required this.setNumber,
    required this.statusOfUser,
    required this.duration,
    required this.datas,
  });
  @override
  State<TraningFinish> createState() => _TraningFinishState();
}

class _TraningFinishState extends State<TraningFinish> {
  TrainingService trainingService = TrainingService();
  String? statusOfTheUser;
  final statusValue = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  DropdownMenuItem<String> statusMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
  TextEditingController exercise = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController setNumber = new TextEditingController();
  @override
  void initState() {
    exercise.text = widget.exerciseName;
    weight.text = widget.weight.toString();
    setNumber.text = widget.setNumber.toString();
    statusOfTheUser = widget.statusOfUser.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Overview'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                              widget.muscleImage,
                            ),
                          )),
                      SizedBox(height: 10),
                      Text(widget.muscle),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.4,
                    child: SfCartesianChart(
                        primaryYAxis: NumericAxis(maximum: 6, minimum: 0),
                        primaryXAxis: NumericAxis(isVisible: false),
                        series: <ChartSeries>[
                          FastLineSeries<dynamic, int>(
                              dataSource: widget.datas,
                              xValueMapper: (datas, _) => i++,
                              yValueMapper: (datas, _) =>
                                  double.parse(datas.toString()))
                        ]),
                  ),
                ),
              ],
            ),
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
                    prefixIcon: Icon(FontAwesomeIcons.weightScale),
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
                    prefixIcon: Icon(FontAwesomeIcons.listOl),
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
                    onChanged: (value) =>
                        setState(() => this.statusOfTheUser = value as String),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        width * 0.3,
                        height * 0.06,
                      ),
                    ),
                    onPressed: () async {
                      List<double> feature = <double>[];
                      await trainingService.createSet(
                          exercise.text,
                          widget.muscle,
                          double.parse(weight.text),
                          int.parse(setNumber.text),
                          int.parse(
                            widget.statusOfUser.toString(),
                          ),
                          int.parse(widget.duration.toString()),
                          widget.datas.toList(),
                          widget.server,
                          context,
                          feature);
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        width * 0.3,
                        height * 0.06,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => TrainingOne(
                                    server: widget.server,
                                  )),
                          (Route<dynamic> route) => false);
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
