import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/models/User.dart';
import 'package:mobileapp/screens/home_page.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/UserInformations';
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController date = TextEditingController();

  String? gender;
  final genderItems = ['Male', 'Female', 'Others'];

  String? alcohol;
  final alcoholUse = ['Yes', 'No'];

  String? tobocco;
  final toboccoUse = ['Yes', 'No'];

  DropdownMenuItem<String> genderMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  DropdownMenuItem<String> alcoholMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));
  DropdownMenuItem<String> toboccoMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final userRef = FirebaseFirestore.instance
      .collection('User')
      .withConverter<UserInformations>(
        fromFirestore: (snapshot, _) =>
            UserInformations.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future updateUser() async {
    try {
      await userRef
          .doc(_auth.currentUser!.uid)
          .update({
            'name': name.text.toLowerCase(),
            'surname': surName.text.toLowerCase(),
            'gender': gender!.toLowerCase(),
            'dateofBirth': date.text.toString(),
            'alcohol': alcohol!.toLowerCase(),
            'tobocco': tobocco!.toLowerCase(),
          })
          .then((value) =>
              Navigator.of(context).pushReplacementNamed(HomePage.routeName))
          .onError((error, stackTrace) =>
              showErrorDialog('An error occured! Please try again.'));
    } catch (e) {
      showErrorDialog('An error occured! Please try again');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('User Informations'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                    'Before you continue, we need more information about you.'),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: surName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Surname',
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: date,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Birthday',
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gender:'),
                    DropdownButton(
                      value: gender,
                      items: genderItems.map(genderMenuItem).toList(),
                      onChanged: (value) =>
                          setState(() => this.gender = value as String),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Alcohol Use:'),
                    DropdownButton(
                      value: alcohol,
                      items: alcoholUse.map(alcoholMenuItem).toList(),
                      onChanged: (value) =>
                          setState(() => this.alcohol = value as String),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tobocco Use:'),
                    DropdownButton(
                      value: tobocco,
                      items: toboccoUse.map(toboccoMenuItem).toList(),
                      onChanged: (value) =>
                          setState(() => this.tobocco = value as String),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    updateUser();
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
