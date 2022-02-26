import 'package:flutter/material.dart';
import 'package:mobileapp/screens/login.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class ResetPassword extends StatelessWidget {
  static const routeName = '/ResetPassword';

  AuthenticationService auth = AuthenticationService();

  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void showInfoDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('E-mail sended!'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child:
                  Text('Password reset email sended. Please check your email.'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Your Password'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Text your e-mail for reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: 150,
                height: 45,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    auth.sendResetPasswordEmail(email.text.trim());
                    Navigator.of(context)
                        .pushReplacementNamed(SignInScreen.routeName);
                  },
                  child: Text(
                    'Send E-mail',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
