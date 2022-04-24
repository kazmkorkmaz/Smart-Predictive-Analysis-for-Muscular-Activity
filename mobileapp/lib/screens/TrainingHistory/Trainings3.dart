import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:mobileapp/widgets/Training/training-exercise-card.dart';

class Trainings3 extends StatefulWidget {
  final String muscle;
  final String date;
  Trainings3({required this.muscle, required this.date});
  @override
  _Trainings3State createState() => _Trainings3State();
}

class _Trainings3State extends State<Trainings3> {
  TrainingService training = TrainingService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainings'),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: training.getExercise(widget.date, widget.muscle),
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
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final item = dataList[index];
                return TrainingExerciseCard(
                  exercise: item.id,
                  date: widget.date,
                  muscle: widget.muscle,
                );
              },
            );
          }),
    );
  }
}
