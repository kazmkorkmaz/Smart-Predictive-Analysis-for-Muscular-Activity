import 'package:flutter/material.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/Auth/login.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class ResetPassword extends StatelessWidget {
  static const routeName = '/ResetPassword';

  AuthenticationService auth = AuthenticationService();
  TextEditingController email = TextEditingController();
  MyDialog dialog = MyDialog();
  @override
  Widget build(BuildContext context) {
    void showInfoDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('E-mail sended!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Okey',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Your Password'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                Image.asset(
                  'lib/assets/images/bee-strong-avatar.png',
                  width: width * 0.45,
                  height: height * 0.3,
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                Text(
                  'Text your e-mail for reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ButtonTheme(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                      width * 0.9,
                      height * 0.06,
                    )),
                    onPressed: () async {
                      if (email.text.isEmpty) {
                        dialog.showErrorDialog('Email text is empty!', context);
                      } else {
                        dynamic result = await auth
                            .sendResetPasswordEmail(email.text.trim());
                        if (result == null) {
                          showInfoDialog(
                              'Password reset email sended. Please check your email.');
                        } else {
                          dialog.showErrorDialog(result, context);
                        }
                      }
                    },
                    child: Text(
                      'Send E-mail',
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
