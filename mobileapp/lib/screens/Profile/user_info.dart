import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/services/user_firebase.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/UserInformations';

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController date = TextEditingController();
  DateTime? dateF;
  UserService userService = UserService();
  MyDialog dialog = MyDialog();

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
  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter these personal informations',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'before starting!',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                padding: const EdgeInsets.all(4.0),
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
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: date,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'Birthday',
                      prefixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder()),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2022));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        date.text = formattedDate;
                        dateF = pickedDate;
                      });
                    } else {
                      dialog.showErrorDialog('Date is not selected!', context);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                padding: const EdgeInsets.all(4.0),
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
                padding: const EdgeInsets.all(4.0),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                    width * 0.7,
                    height * 0.05,
                  )),
                  onPressed: () {
                    userService.updateUser(name.text, surName.text, gender!,
                        dateF!, alcohol!, tobocco!, context);
                  },
                  child: Text(
                    'Continue',
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.04),
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
