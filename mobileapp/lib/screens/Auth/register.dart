import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobileapp/commons/dialog.dart';
import 'package:mobileapp/screens/home_page.dart';
import 'package:mobileapp/screens/Auth/login.dart';
import 'package:mobileapp/services/auth_firebase.dart';
import 'package:mobileapp/widgets/termsAndPolicy.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/SignUp';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthenticationService auth = AuthenticationService();

  TextEditingController emailText = TextEditingController();

  TextEditingController passwordText = TextEditingController();

  TextEditingController cpasswordText = TextEditingController();

  FocusNode confirmPass = FocusNode();

  FocusNode password = FocusNode();

  var message = '';

  MyDialog dialog = MyDialog();

  @override
  Widget build(BuildContext context) {
    void showInfoDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('E-mail verification!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    void register() async {
      if (passwordText.text == '' ||
          cpasswordText.text == '' ||
          emailText.text == '') {
        message = 'Email or password field is empty!';
        dialog.showErrorDialog(message, context);
      } else if (passwordText.text != cpasswordText.text) {
        message = 'Passwords are not match!';
        dialog.showErrorDialog(message, context);
      } else {
        dynamic result = await auth.register(emailText.text, passwordText.text);
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          if (!user.emailVerified) {
            await auth.sendVerificationMail();
            showInfoDialog(
                'Please check your e-mail for verification! if you didn\'nt see the e-mail, check your spam box.');
          } else {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }
        } else {
          message = result.toString();
          dialog.showErrorDialog(message, context);
        }
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.all(4.0),
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
              padding: const EdgeInsets.all(4.0),
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
              padding: EdgeInsets.only(top: height * 0.03),
              child: Builder(builder: (ctx) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                    width * 0.9,
                    height * 0.06,
                  )),
                  onPressed: register,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            SignInScreen.routeName,
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('By Creating an acoount, you are agreeing to MuscleNET'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return TermsAndPolicy(
                              fileName: 'terms_conditions.md');
                        });
                  },
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('and'),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return TermsAndPolicy(fileName: 'privacy_policy.md');
                        });
                  },
                  child: Text(
                    ' Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
