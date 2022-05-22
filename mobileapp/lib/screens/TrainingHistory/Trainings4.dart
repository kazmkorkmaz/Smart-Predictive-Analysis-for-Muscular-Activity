import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/TrainingHistory/last_five_prediction.dart';
import 'package:mobileapp/services/ml_firebase.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:mobileapp/widgets/Training/training-sets-card.dart';

class Trainings4 extends StatefulWidget {
  final String muscle;
  final String date;
  final String exercise;
  Trainings4(
      {required this.muscle, required this.date, required this.exercise});
  @override
  _Trainings4State createState() => _Trainings4State();
}

class _Trainings4State extends State<Trainings4> {
  TrainingService training = TrainingService();
  ML_Service ml_service = ML_Service();
  MyDialog dialog = MyDialog();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Set'),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: training.getSets(widget.date, widget.muscle, widget.exercise),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('An error occured! Please try later...'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading...'),
                  ],
                ),
              );
            }
            final dataList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: dataList.length + 1,
              itemBuilder: (context, index) {
                if (index == dataList.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (dataList.length >= 5) {
                          training
                              .getLastFiveSet(
                                  widget.date, widget.muscle, widget.exercise)
                              .then((value) {
                            List input = [];
                            value.docs.forEach((element) {
                              input.add(element.get('features'));
                            });

                            List doubleFeatures = [];
                            for (var i = input.length - 1; i >= 0; i--) {
                              for (var j = 0; j < 16; j++) {
                                doubleFeatures
                                    .add(double.parse(input[i][j].toString()));
                              }
                            }

                            ml_service
                                .predictLastFive(doubleFeatures)
                                .then((value) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LastFivePredictionScreen(
                                      index: value,
                                      nameOfTrainings: widget.date,
                                      muscleName: widget.muscle,
                                      exerciseName: widget.exercise,
                                    );
                                  },
                                ),
                              );
                            }).onError((error, stackTrace) {
                              dialog.showErrorDialog(
                                  'An error occured! Please try again!',
                                  context);
                            });
                          });
                        } else {
                          dialog.showErrorDialog(
                              'You have to complete at least five set. Then you can see the report.',
                              context);
                        }
                      },
                      child: Text(
                        'See Report',
                      ),
                    ),
                  );
                }
                final item = dataList[index];
                return TrainingSetsCard(
                  exercise: widget.exercise,
                  sets: item.id,
                  date: widget.date,
                  muscle: widget.muscle,
                );
              },
            );
          }),
    );
  }
}
