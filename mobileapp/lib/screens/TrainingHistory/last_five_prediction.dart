import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LastFivePredictionScreen extends StatelessWidget {
  String nameOfTrainings;
  String muscleName;
  String exerciseName;
  int index;
  LastFivePredictionScreen(
      {required this.index,
      required this.nameOfTrainings,
      required this.muscleName,
      required this.exerciseName});
  @override
  Widget build(BuildContext context) {
    TrainingService trainingService = TrainingService();
    String riskText = '';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int i = 0;
    int j = 0;
    int k = 0;
    int l = 0;
    int m = 0;
    if (index == 0) {
      riskText =
          "You can continue training with this weights. According to last five set, there is no danger to your muscle health.";
    } else {
      riskText =
          "According to last five set, working with this weights can be risky for your muscle health in the next sets.";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Risk Prediction'),
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: trainingService.getLastFiveSet(
                nameOfTrainings, muscleName, exerciseName),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('An error occured! Please try later...'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                double averageDuration = 0;
                double sumOfDurations = 0;
                double averageWeights = 0;
                double sumOfWeights = 0;
                snapshot.data!.docs.forEach((element) {
                  sumOfDurations += element.get('duration');
                  sumOfWeights += element.get('weight');
                });
                averageDuration = sumOfDurations / 5;
                averageWeights = sumOfWeights / 5;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: SfCartesianChart(
                          legend: Legend(
                              isVisible: true, position: LegendPosition.bottom),
                          title: ChartTitle(text: 'Trainings data'),
                          primaryYAxis: NumericAxis(maximum: 6, minimum: 0),
                          primaryXAxis: NumericAxis(isVisible: false),
                          series: <ChartSeries>[
                            FastLineSeries<dynamic, int>(
                              dataSource: snapshot.data!.docs[0].get('datas'),
                              xValueMapper: (datas, _) => i++,
                              yValueMapper: (datas, _) =>
                                  double.parse(datas.toString()),
                              name:
                                  '${snapshot.data!.docs[0].get('setNumber').toString()}',
                            ),
                            FastLineSeries<dynamic, int>(
                              dataSource: snapshot.data!.docs[1].get('datas'),
                              xValueMapper: (datas, _) => j++,
                              yValueMapper: (datas, _) =>
                                  double.parse(datas.toString()),
                              name:
                                  '${snapshot.data!.docs[1].get('setNumber').toString()}',
                            ),
                            FastLineSeries<dynamic, int>(
                              dataSource: snapshot.data!.docs[2].get('datas'),
                              xValueMapper: (datas, _) => k++,
                              yValueMapper: (datas, _) =>
                                  double.parse(datas.toString()),
                              name:
                                  '${snapshot.data!.docs[2].get('setNumber').toString()}',
                            ),
                            FastLineSeries<dynamic, int>(
                              dataSource: snapshot.data!.docs[3].get('datas'),
                              xValueMapper: (datas, _) => l++,
                              yValueMapper: (datas, _) =>
                                  double.parse(datas.toString()),
                              name:
                                  '${snapshot.data!.docs[3].get('setNumber').toString()}',
                            ),
                            FastLineSeries<dynamic, int>(
                              dataSource: snapshot.data!.docs[4].get('datas'),
                              xValueMapper: (datas, _) => m++,
                              yValueMapper: (datas, _) =>
                                  double.parse(datas.toString()),
                              name:
                                  '${snapshot.data!.docs[4].get('setNumber').toString()}',
                            ),
                          ],
                        ),
                      ),
                      ExpansionPanelList.radio(
                        children: [
                          ExpansionPanelRadio(
                            canTapOnHeader: true,
                            value: "risk",
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                title: Text(
                                  "Risk Injury",
                                ),
                              );
                            },
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(riskText),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
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
                            Icons.timer,
                            size: 35,
                          ),
                          SizedBox(width: width * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Average Duration:',
                                textScaleFactor: 1.2,
                              ),
                              Text(
                                averageDuration.toString(),
                                textScaleFactor: 1.2,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.015,
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
                                snapshot.data!.docs[0]
                                    .get('muscleName')
                                    .toString(),
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
                                snapshot.data!.docs[0]
                                    .get('exerciseName')
                                    .toString(),
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
                                'Average Weight:',
                                textScaleFactor: 1.2,
                              ),
                              Text(
                                averageWeights.toString(),
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
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
