import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/screens/Training/training_one.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrainingsFive extends StatefulWidget {
  final BluetoothDevice server;
  final String muscle;
  final String date;
  final String exercise;
  final String setNumber;
  TrainingsFive(
      {required this.muscle,
      required this.date,
      required this.exercise,
      required this.setNumber,
      required this.server});
  @override
  _TrainingsFiveState createState() => _TrainingsFiveState();
}

class _TrainingsFiveState extends State<TrainingsFive> {
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
              String injuryText;
              int riskInjury = int.parse(data["riskInjury"].toString());
              if (riskInjury == 0) {
                injuryText =
                    "You can continue training with this weight. There is no danger to your muscle health.";
              } else {
                injuryText =
                    "Working with this weight can be risky for your muscle health in the next sets.";
              }
              String improvement;
              int impStatus = int.parse(data["impStatus"].toString());
              if (impStatus == 0) {
                improvement =
                    "You may lift heavier weight in your next training sets.";
              } else if (impStatus == 1) {
                improvement = "This weight is ideal for your training.";
              } else {
                improvement =
                    "You should try to lift lighter weight in your next training sets.";
              }
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
                                      title: ChartTitle(text: 'Training data'),
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
                          ExpansionPanelList.radio(
                            children: [
                              ExpansionPanelRadio(
                                canTapOnHeader: true,
                                value: "risk",
                                headerBuilder: (context, isExpanded) {
                                  return ListTile(
                                    title: Text(
                                      "Injury Risk",
                                    ),
                                  );
                                },
                                body: Text(injuryText),
                              ),
                              ExpansionPanelRadio(
                                canTapOnHeader: true,
                                value: "improvement",
                                headerBuilder: (context, isExpanded) {
                                  return ListTile(
                                    title: Text(
                                      "Improvement Status",
                                    ),
                                  );
                                },
                                body: Text(improvement),
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
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                            builder: (context) => HomePage(
                                                  server: widget.server,
                                                )),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text('Back Home'),
                                ),
                              ],
                            ),
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
