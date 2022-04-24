import 'package:flutter/material.dart';
import 'package:mobileapp/screens/TrainingHistory/Trainings2.dart';

class TrainingDateCard extends StatelessWidget {
  final String date;
  TrainingDateCard({required this.date});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Trainings2(
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
              title: Text(date),
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
