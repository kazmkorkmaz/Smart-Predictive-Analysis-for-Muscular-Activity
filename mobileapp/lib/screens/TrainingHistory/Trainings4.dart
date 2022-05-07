import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              itemCount: dataList.length,
              itemBuilder: (context, index) {
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
