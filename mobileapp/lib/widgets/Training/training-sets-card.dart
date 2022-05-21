import 'package:flutter/material.dart';
import 'package:mobileapp/screens/TrainingHistory/Trainings5.dart';

class TrainingSetsCard extends StatelessWidget {
  final String sets;
  final String exercise;
  final String muscle;
  final String date;
  TrainingSetsCard(
      {required this.sets,
      required this.date,
      required this.exercise,
      required this.muscle});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Trainings5(
                muscle: muscle,
                date: date,
                exercise: exercise,
                setNumber: sets,
              );
            },
          ),
        );
      },
      child: Card(
        child: Container(
          width: double.infinity,
          height: 50,
          child: Center(
            child: ListTile(
              title: Text(sets),
            ),
          ),
        ),
        shadowColor: Colors.orangeAccent,
        elevation: 8,
        margin: EdgeInsets.all(8),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orangeAccent, width: 1)),
      ),
    );
  }
}
