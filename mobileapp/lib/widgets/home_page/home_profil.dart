import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/screens/Profile/profile.dart';

class HomeProfilCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProfilePage.routeName);
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
              child: Icon(
                FontAwesomeIcons.addressCard,
                size: height * 0.2,
              ),
            ),
            SizedBox(height: height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.05, height: height * 0.05),
                Text(
                  'Profile',
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
                  'Profile informations about you..',
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
