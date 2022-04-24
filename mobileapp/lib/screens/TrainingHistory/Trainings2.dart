import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/services/training_firebase.dart';
import 'package:mobileapp/widgets/Training/training-date-card.dart';
import 'package:mobileapp/widgets/Training/training-muscle-card.dart';

class Trainings2 extends StatefulWidget {
  final String date;
  Trainings2({required this.date});
  @override
  _Trainings2State createState() => _Trainings2State();
}

class _Trainings2State extends State<Trainings2> {
  TrainingService training = TrainingService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainings'),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: training.getMusclesGroup(widget.date),
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
            final dataList = snapshot.data!.docs.toList();
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final item = dataList[index];
                return TrainingMuscleCard(
                  muscle: item.id,
                  date: widget.date,
                );
              },
            );
          }),
    );
  }
}
