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
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            return snapshot.connectionState != ConnectionState.done
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Image.asset(
                                'lib/assets/images/bee-strong-avatar.png',
                                width: width * 0.8,
                                height: height * 0.2,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Center(
                                child: Text(
                                  snapshot.data.name.toString().toUpperCase() +
                                      ' ' +
                                      snapshot.data.surname
                                          .toString()
                                          .toUpperCase(),
                                  textScaleFactor: 1.8,
                                  style: TextStyle(
                                      fontFamily: 'LuckiestGuy',
                                      color: Colors.black),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Colors.orange, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Age',
                                              textScaleFactor: 1.2,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              snapshot.data.age,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Birthday',
                                              textScaleFactor: 1.2,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              snapshot.data.dateofBirth,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Colors.orange, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "User Informations",
                                          textScaleFactor: 1.4,
                                          style: TextStyle(
                                              fontFamily: 'IndieFlower'),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 5,
                                      thickness: 1,
                                      indent: 5,
                                      endIndent: 0,
                                      color: Colors.orange,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: width * 0.02),
                                        Icon(
                                          Icons.email,
                                          size: 35,
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'E-mail:',
                                              textScaleFactor: 1.2,
                                            ),
                                            Text(
                                              snapshot.data.email,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: width * 0.02),
                                        Icon(
                                          Icons.emoji_people,
                                          size: 35,
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Gender:',
                                              textScaleFactor: 1.2,
                                            ),
                                            Text(
                                              snapshot.data.gender,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: width * 0.02),
                                        Icon(
                                          Icons.no_drinks,
                                          size: 35,
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Alcohol:',
                                              textScaleFactor: 1.2,
                                            ),
                                            Text(
                                              snapshot.data.alcohol,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: width * 0.02),
                                        Icon(
                                          Icons.smoke_free,
                                          size: 35,
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tobocco:',
                                              textScaleFactor: 1.2,
                                            ),
                                            Text(
                                              snapshot.data.tobocco,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: width * 0.02),
                                        Icon(
                                          Icons.date_range,
                                          size: 35,
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Register Date:',
                                              textScaleFactor: 1.2,
                                            ),
                                            Text(
                                              snapshot.data.registerDate,
                                              textScaleFactor: 1.2,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.015,
                                    ),
                                  ],
                                ),
                              ),
                              BodyMeasurementsWidget(),
                              SizedBox(
                                height: height * 0.015,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                  width * 0.3,
                                  height * 0.06,
                                )),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      UpdateBodyMeasurements.routeName);
                                },
                                child: Text(
                                  'Update Body Measurements',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04),
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
