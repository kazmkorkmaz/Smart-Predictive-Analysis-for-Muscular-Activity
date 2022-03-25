import 'package:flutter/material.dart';
import 'package:mobileapp/screens/Auth/login.dart';
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
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    void showErrDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured!'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.white,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child:
                        Image.asset('lib/assets/images/bee-strong-avatar.png')),
              ),
              SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  'Bee Strong!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Text your e-mail for reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 25,
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
                height: 25,
              ),
              ButtonTheme(
                child: RaisedButton(
                  onPressed: () async {
                    if (email.text.isEmpty) {
                      showErrDialog('Email text is empty!');
                    } else {
                      dynamic result =
                          await auth.sendResetPasswordEmail(email.text.trim());
                      print(result);
                      if (result == null) {
                        showInfoDialog(
                            'Password reset email sended. Please check your email.');
                      } else {
                        showErrDialog(result);
                      }
                    }
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
