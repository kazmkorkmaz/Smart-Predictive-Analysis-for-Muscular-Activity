import 'package:flutter/material.dart';
import 'package:mobileapp/screens/TrainingHistory/Trainings4.dart';

class TrainingExerciseCard extends StatelessWidget {
  final String exercise;
  final String muscle;
  final String date;
  TrainingExerciseCard(
      {required this.exercise, required this.muscle, required this.date});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Trainings4(
                muscle: muscle,
                date: date,
                exercise: exercise,
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
              title: Text(exercise),
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
