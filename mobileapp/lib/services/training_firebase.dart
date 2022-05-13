import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/Training/training_five.dart';
import 'package:mobileapp/services/functions_firebase.dart';
import 'package:mobileapp/services/ml_firebase.dart';
import 'package:mobileapp/services/user_firebase.dart';

class TrainingService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CloudFunctionsService cloudFunctionsService = CloudFunctionsService();
  UserService userService = UserService();
  ML_Service ml_service = ML_Service();
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
      BuildContext context,
      List<double> features) async {
    try {
      DateTime date = DateTime.now().toLocal();
      var nameOfTrainings = '${date.day}-${date.month}-${date.year}';
      await firestore
          .collection('User')
          .doc(_auth.currentUser!.uid)
          .collection('Trainings')
          .doc(nameOfTrainings)
          .set({'createdAt': DateTime.now()});
      await firestore
          .collection('User')
          .doc(_auth.currentUser!.uid)
          .collection('Trainings')
          .doc(nameOfTrainings)
          .collection('MuscleGroup')
          .doc(muscleName)
          .set({'muscleName': muscleName});
      await firestore
          .collection('User')
          .doc(_auth.currentUser!.uid)
          .collection('Trainings')
          .doc(nameOfTrainings)
          .collection('MuscleGroup')
          .doc(muscleName)
          .collection('ExerciseName')
          .doc(exerciseName)
          .set({'exerciseName': exerciseName});
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
        'features': features.toList(),
      }).then((value) => getDatas(nameOfTrainings, muscleName, exerciseName,
                      'SetNumber-' + setNumber.toString())
                  .then((value) {
                final datas = value.get('datas').toList();
                cloudFunctionsService.writeFeatures(datas).then((value) {
                  updateSetWithFeatures(exerciseName, muscleName, weight,
                          setNumber, value.toList())
                      .then((value) {
                    updateWithMachineLearning(
                        exerciseName, muscleName, weight, setNumber, value);
                  }).then((value) => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TrainingsFive(
                                  server: server,
                                  muscle: muscleName,
                                  date: nameOfTrainings,
                                  exercise: exerciseName,
                                  setNumber:
                                      'SetNumber-' + setNumber.toString(),
                                );
                              },
                            ),
                          ).onError((error, stackTrace) =>
                              dialog.showErrorDialog(
                                  'An error occured. Please try again!',
                                  context)));
                });
              }));
    } catch (e) {
      dialog.showErrorDialog('An error occured. Please try again!', context);
    }
  }

  Future updateSetWithFeatures(String exerciseName, String muscleName,
      double weight, int setNumber, List features) async {
    DateTime date = DateTime.now().toLocal();
    var nameOfTrainings = '${date.day}-${date.month}-${date.year}';

    var userBody;
    var userGender;

    var userData = await userService.getBodydata().then((value) {
      userBody = value.docs.first.data();
    });
    var userInfoData = await userService.getUserData().then((value) {
      userGender = value!.gender;
    });

    var genderNumber;
    if (userGender == "male") {
      genderNumber = 1;
    } else {
      genderNumber = 0;
    }
    features.add(userBody["fPower"]);
    features.add(genderNumber);
    features.add(weight);

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
        .update({'features': features}).onError(
            (error, stackTrace) => print('Hata'));
    return features;
  }

  Future updateWithMachineLearning(String exerciseName, String muscleName,
      double weight, int setNumber, List features) async {
    DateTime date = DateTime.now().toLocal();
    var nameOfTrainings = '${date.day}-${date.month}-${date.year}';

    List doubleFeatures = [];
    features.forEach((element) {
      doubleFeatures.add(double.parse(element.toString()));
    });

    int? injRisk;
    var predictInj =
        await ml_service.predictInjuryRisk([doubleFeatures]).then((value) {
      injRisk = value.toInt();
    });
    int? impStatus;
    var predictImpr =
        await ml_service.predictImprovement([doubleFeatures]).then((value) {
      impStatus = value.toInt();
    });
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
        .update({"riskInjury": injRisk, "impStatus": impStatus}).onError(
            (error, stackTrace) => print('Hata'));
    return features;
  }

  Future<QuerySnapshot> getTraining() async {
    final datesRef = await FirebaseFirestore.instance
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('Trainings')
        .get();

    return datesRef;
  }

  Future<QuerySnapshot> getMusclesGroup(String nameOfTrainings) async {
    final datesRef = await FirebaseFirestore.instance
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('Trainings')
        .doc(nameOfTrainings)
        .collection('MuscleGroup')
        .get();

    return datesRef;
  }

  Future<QuerySnapshot> getExercise(
      String nameOfTrainings, String muscleName) async {
    final datesRef = await firestore
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('Trainings')
        .doc(nameOfTrainings)
        .collection('MuscleGroup')
        .doc(muscleName)
        .collection('ExerciseName')
        .get();

    return datesRef;
  }

  Future<QuerySnapshot> getSets(
      String nameOfTrainings, String muscleName, String exerciseName) async {
    final datesRef = await firestore
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('Trainings')
        .doc(nameOfTrainings)
        .collection('MuscleGroup')
        .doc(muscleName)
        .collection('ExerciseName')
        .doc(exerciseName)
        .collection('Sets')
        .get();

    return datesRef;
  }

  Future<DocumentSnapshot> getDatas(String nameOfTrainings, String muscleName,
      String exerciseName, String setNumber) async {
    final datesRef = await firestore
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('Trainings')
        .doc(nameOfTrainings)
        .collection('MuscleGroup')
        .doc(muscleName)
        .collection('ExerciseName')
        .doc(exerciseName)
        .collection('Sets')
        .doc(setNumber)
        .get();

    return datesRef;
  }
}
