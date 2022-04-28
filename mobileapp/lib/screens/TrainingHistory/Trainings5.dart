import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:mobileapp/widgets/Training/training-exercise-card.dart';
import 'package:mobileapp/widgets/Training/training-sets-card.dart';
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
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainings'),
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
              print(data['datas']);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      height: 200,
                      child: SfCartesianChart(series: <ChartSeries>[
                        // Renders line chart
                        FastLineSeries<dynamic, int>(
                            dataSource: data['datas'].toList(),
                            xValueMapper: (datas, _) => i++,
                            yValueMapper: (datas, _) =>
                                double.parse(datas.toString()))
                      ]),
                    ),
                  ),
                ],
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
