import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Trainings5 extends StatefulWidget {
  final String muscle;
  final String date;
  final String exercise;
  final String setNumber;
  Trainings5(
      {required this.muscle,
      required this.date,
      required this.exercise,
      required this.setNumber});
  @override
  _Trainings5State createState() => _Trainings5State();
}

class _Trainings5State extends State<Trainings5> {
  TrainingService training = TrainingService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Informations'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: training.getDatas(
              widget.date, widget.muscle, widget.exercise, widget.setNumber),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('An error occured! Please try later...'),
              );
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Center(
                child: Text('An error occured! Please try later...'),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          side:
                              new BorderSide(color: Colors.orange, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Training Informations",
                                textScaleFactor: 1.4,
                                style: TextStyle(fontFamily: 'IndieFlower'),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 1,
                            indent: 5,
                            endIndent: 0,
                            color: Colors.orange,
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
                                      primaryYAxis:
                                          NumericAxis(maximum: 6, minimum: 0),
                                      primaryXAxis:
                                          NumericAxis(isVisible: false),
                                      series: <ChartSeries>[
                                        FastLineSeries<dynamic, int>(
                                            dataSource: data['datas'].toList(),
                                            xValueMapper: (datas, _) => i++,
                                            yValueMapper: (datas, _) =>
                                                double.parse(datas.toString()))
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.02),
                              Icon(
                                Icons.fitness_center_sharp,
                                size: 35,
                              ),
                              SizedBox(width: width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Muscle:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    data['muscleName'].toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.02),
                              Icon(
                                FontAwesomeIcons.dumbbell,
                                size: 35,
                              ),
                              SizedBox(width: width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Exercise Name:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    data['exerciseName'].toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.02),
                              Icon(
                                Icons.numbers,
                                size: 35,
                              ),
                              SizedBox(width: width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Set Number:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    data['setNumber'].toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.02),
                              Icon(
                                FontAwesomeIcons.weightScale,
                                size: 35,
                              ),
                              SizedBox(width: width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weight:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    data['weight'].toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: width * 0.02),
                              Icon(
                                Icons.timer,
                                size: 35,
                              ),
                              SizedBox(width: width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration:',
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    data['duration'].toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Loading...'),
                  ],
                )
              ],
            );
          }),
    );
  }
}
