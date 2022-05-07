import 'package:flutter/material.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/TrainingHistory/Trainings.dart';

class HomeTrainingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyDialog dialog = MyDialog();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Trainings.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orangeAccent, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 64,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Icon(
                  Icons.history_edu,
                  size: height * 0.2,
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.05, height: height * 0.05),
                Text(
                  'Training History',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Divider(
              color: Colors.orangeAccent,
              height: 10,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(height: height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.025),
                Text(
                  'History of your trainings',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
