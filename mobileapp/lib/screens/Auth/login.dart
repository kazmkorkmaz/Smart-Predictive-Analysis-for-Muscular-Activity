import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/Auth/reset_password.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/Auth/register.dart';
import 'package:mobileapp/screens/Profile/user_info.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/SignIn';
  AuthenticationService auth = AuthenticationService();

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  MyDialog dialog = MyDialog();
  var message = '';

  @override
  Widget build(BuildContext context) {
    void signIn() async {
      dynamic result = await auth.signIn(emailText.text, passwordText.text);
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (emailText.text != '' && passwordText.text != '') {
        if (_auth.currentUser != null && _auth.currentUser!.emailVerified) {
          FirebaseFirestore.instance
              .collection('User')
              .doc(_auth.currentUser!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              var name = documentSnapshot.get('name');

              if (name == null) {
                Navigator.of(context)
                    .pushReplacementNamed(UserInfoScreen.routeName);
              } else {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              }
            }
          });
        } else {
          message = result.toString();
          dialog.showErrorDialog(message, context);
        }
      } else {
        message = 'Email or password field is empty!';
        dialog.showErrorDialog(message, context);
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              Image.asset(
                'lib/assets/images/bee-strong-avatar.png',
                width: width * 0.5,
                height: height * 0.3,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: emailText,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: passwordText,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ResetPassword.routeName);
                        },
                        child: const Text('Forgot Password ?')),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                    width * 0.9,
                    height * 0.06,
                  )),
                  onPressed: signIn,
                  child: Text(
                    'Sign In',
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.06),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routeName);
                        },
                        child: const Text('Sign Up')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
