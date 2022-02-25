import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/login.dart';
import 'package:mobileapp/services/auth_firebase.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/SignUp';

  AuthenticationService auth = AuthenticationService();

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController cpasswordText = TextEditingController();
  FocusNode confirmPass = FocusNode();
  FocusNode password = FocusNode();
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

    void register() async {
      if (passwordText.text != cpasswordText.text) {
        message = 'Passwords are not match!';
        showErrorDialog(message);
      } else {
        dynamic result = await auth.register(emailText.text, passwordText.text);
        User? user = FirebaseAuth.instance.currentUser;
        print(result);
        if (user != null) {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        } else {
          message = result.toString();
          showErrorDialog(message);
        }
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
                  'Sign Up',
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
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordText,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cpasswordText,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Builder(builder: (ctx) {
                  return RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.blueAccent,
                    onPressed: register,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already Have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignInScreen.routeName);
                        },
                        child: const Text('Sign In')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
