import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/models/User.dart';
import 'package:mobileapp/models/body_measurements.dart';
import 'package:mobileapp/screens/BodyMeasurements/body_measurements.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/Profile/profile.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyDialog dialog = new MyDialog();

  final userRef = FirebaseFirestore.instance
      .collection('User')
      .withConverter<UserInformations>(
        fromFirestore: (snapshot, _) =>
            UserInformations.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
  final bodyRef = FirebaseFirestore.instance
      .collection('User')
      .withConverter<BodyMeasurementsInfo>(
        fromFirestore: (snapshot, _) =>
            BodyMeasurementsInfo.fromJson(snapshot.data()!),
        toFirestore: (body, _) => body.toJson(),
      );

  Future addUser(String uid, String email, String registerDate) async {
    await userRef.doc(uid).set(UserInformations(
          id: uid,
          email: email,
          registerDate: registerDate,
        ));
  }

  Future updateUser(String name, String surName, String gender, DateTime date,
      String alcohol, String tobocco, BuildContext context) async {
    var dateOfBirth = '${date.day}-${date.month}-${date.year}';
    int age = DateTime.now().year - date.year;

    try {
      await userRef
          .doc(_auth.currentUser!.uid)
          .update({
            'name': name.toLowerCase().trim(),
            'surname': surName.toLowerCase().trim(),
            'gender': gender.toLowerCase().trim(),
            'dateofBirth': dateOfBirth.toString(),
            'alcohol': alcohol.toLowerCase().trim(),
            'tobocco': tobocco.toLowerCase().trim(),
            'age': age.toString(),
          })
          .then((value) => Navigator.of(context)
              .pushReplacementNamed(BodyMeasurements.routeName))
          .onError((error, stackTrace) =>
              dialog.showErrorDialog('An error occured! Please try ', context));
    } catch (e) {
      dialog.showErrorDialog('An error occured! Please try again', context);
    }
  }

  Future<UserInformations?> getUserData() async {
    final userRef = await FirebaseFirestore.instance
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .withConverter<UserInformations>(
          fromFirestore: (snapshot, _) =>
              UserInformations.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    return userRef.data();
  }

  Future addBody(
    double height,
    double weight,
    double arm,
    double chest,
    double shoulder,
    double tobocco,
    double waist,
    double hipst,
    double thigh,
    DateTime createdAt,
  ) async {
    DateTime date = DateTime.now().toLocal();
    var dateOfBody = '${date.day}-${date.month}-${date.year}';
    await bodyRef
        .doc(_auth.currentUser!.uid)
        .collection('BodyMeasurements')
        .doc(dateOfBody)
        .set({
      'height': height,
      'weight': weight,
      'arm': arm,
      'chest': chest,
      'shoulder': shoulder,
      'waist': waist,
      'hipst': hipst,
      'thigh': thigh,
      'createdAt': createdAt,
    });
  }

  Future updateBody(
      double height,
      double weight,
      double arm,
      double chest,
      double shoulder,
      double waist,
      double hipst,
      double thigh,
      BuildContext context) async {
    try {
      DateTime date = DateTime.now().toLocal();
      var dateOfBody =
          '${date.day}-${date.month}-${date.year}->${date.hour}:${date.minute}:${date.second}';
      await bodyRef
          .doc(_auth.currentUser!.uid)
          .collection('BodyMeasurements')
          .doc(dateOfBody)
          .set({
            'height': height,
            'weight': weight,
            'arm': arm,
            'chest': chest,
            'shoulder': shoulder,
            'waist': waist,
            'hipst': hipst,
            'thigh': thigh,
            'createdAt': DateTime.now().toLocal(),
          })
          .then((value) =>
              Navigator.of(context).pushReplacementNamed(ProfilePage.routeName))
          .onError((error, stackTrace) =>
              dialog.showErrorDialog('An error occured! Please try ', context));
    } catch (e) {
      dialog.showErrorDialog('An error occured! Please try again', context);
    }
  }

  Future<QuerySnapshot> getBodydata() async {
    final bodyRef = await FirebaseFirestore.instance
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('BodyMeasurements')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    return bodyRef;
  }

  Future<QuerySnapshot> getBodyHistory() async {
    final bodyRef = await FirebaseFirestore.instance
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('BodyMeasurements')
        .get();
    return bodyRef;
  }
}
