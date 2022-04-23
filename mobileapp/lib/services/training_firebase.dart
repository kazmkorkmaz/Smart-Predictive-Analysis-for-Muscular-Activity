import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/home_page.dart';

class TrainingService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  MyDialog dialog = MyDialog();
  Future createSet(
      String exerciseName,
      String muscleName,
      double weight,
      int setNumber,
      int statusOfUser,
      int duration,
      List<double> datas,
      BluetoothDevice server,
      BuildContext context) async {
    try {
      DateTime date = DateTime.now().toLocal();
      var nameOfTrainings = '${date.day}-${date.month}-${date.year}';
      await firestore
          .collection('User')
          .doc(_auth.currentUser!.uid)
          .collection('Trainings')
          .doc(nameOfTrainings)
          .collection('MuscleGroup')
          .doc(muscleName)
          .collection('ExerciseName')
          .doc(exerciseName)
          .collection('Sets')
          .doc('SetNumber-' + setNumber.toString())
          .set({
        'muscleName': muscleName,
        'exerciseName': exerciseName,
        'weight': weight,
        'setNumber': setNumber,
        'statusOfUser': statusOfUser,
        'duration': duration,
        'datas': datas.toList(),
      }).then((value) => Navigator.of(context)
              .pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            server: server,
                          )),
                  (Route<dynamic> route) => false)
              .onError((error, stackTrace) => dialog.showErrorDialog(
                  'An error occured. Please try again!', context)));
    } catch (e) {
      dialog.showErrorDialog('An error occured. Please try again!', context);
    }
  }
}
