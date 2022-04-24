import 'package:flutter/material.dart';
import 'package:mobileapp/screens/TrainingHistory/Trainings3.dart';

class TrainingMuscleCard extends StatelessWidget {
  final String muscle;
  final String date;
  TrainingMuscleCard({required this.muscle, required this.date});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Trainings3(
                muscle: muscle,
                date: date,
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
              title: Text(muscle),
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
