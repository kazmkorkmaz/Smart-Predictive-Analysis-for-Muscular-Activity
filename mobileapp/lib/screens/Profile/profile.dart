import 'package:flutter/material.dart';
import 'package:mobileapp/screens/BodyMeasurements/update_body_measurements.dart';
import 'package:mobileapp/services/user_firebase.dart';
import 'package:mobileapp/widgets/body.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/ProfilePage';

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
          future: userService.getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.connectionState != ConnectionState.done
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                        'lib/assets/images/bee-strong-avatar.png')),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Text(snapshot.data.name
                                        .toString()
                                        .toUpperCase() +
                                    ' ' +
                                    snapshot.data.surname
                                        .toString()
                                        .toUpperCase()),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text('Age'),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(snapshot.data.age),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text('Birthday'),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(snapshot.data.dateofBirth),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text('Trainings'),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text("0")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "User Informations",
                                    ),
                                    Divider(
                                      color: Color.fromARGB(255, 131, 25, 25),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('E-mail:'),
                                            Text(snapshot.data.email),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.emoji_people,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Gender:'),
                                            Text(snapshot.data.gender),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.no_drinks,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Alcohol:'),
                                            Text(snapshot.data.alcohol),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.smoke_free,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Tobocco:'),
                                            Text(snapshot.data.tobocco),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          size: 35,
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Register Date:'),
                                            Text(snapshot.data.registerDate),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              BodyMeasurementsWidget(),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      UpdateBodyMeasurements.routeName);
                                },
                                child: Text(
                                  'Update Body Measurements',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
