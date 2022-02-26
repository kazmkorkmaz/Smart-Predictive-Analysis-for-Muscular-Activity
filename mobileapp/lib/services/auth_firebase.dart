import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUser {
    return _auth.currentUser!.uid;
  }

  Future register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.additionalUserInfo!.isNewUser;
    } on FirebaseAuthException catch (e) {
      var message = '';
      if (e.code == 'email-already-in-use') {
        message = 'Already exists an account with the given email address!';
        return message;
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid!';
        return message;
      } else if (e.code == 'operation-not-allowed') {
        message = 'The email/password accounts are not enabled!';
        return message;
      } else if (e.code == 'weak-password') {
        message = 'The password is not strong enough!';
        return message;
      } else {
        message = e.code.toString();
        return message;
      }
    } catch (e) {
      var message = 'An Error Occurred!';
      return message;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      var message = '';
      if (e.code == 'user-disabled') {
        message = 'Already exists an account with the given email address!';
        return message;
      } else if (e.code == 'invalid-email') {
        message = 'The user corresponding to the given email has been disabled';
        return message;
      } else if (e.code == 'user-not-found') {
        message = 'There is no user corresponding to the given email!';
        return message;
      } else if (e.code == 'wrong-password') {
        message =
            'The password is invalid for the given email, or the account corresponding to the email does not have a password set!';
        return message;
      } else {
        message = e.code.toString();
        return message;
      }
    } catch (e) {
      var message = 'An Error Occurred!';
      return message;
    }
  }

  Future sendVerificationMail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      return 'An Error Occurred!';
    }
  }

  Future sendResetPasswordEmail(email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return 'An Error Occurred!';
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return e;
    }
  }
}
