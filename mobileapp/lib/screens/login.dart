import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/register.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/SignIn';
  AuthenticationService auth = AuthenticationService();

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  var message = '';

  @override
  Widget build(BuildContext context) {
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

    void signIn() async {
      dynamic result = await auth.signIn(emailText.text, passwordText.text);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        message = result.toString();
        showErrorDialog(message);
      }
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailText,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordText,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password ?')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blueAccent,
                  onPressed: signIn,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
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
