import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel extends ChangeNotifier{
  BuildContext _context;
  LoginPageViewModel(this._context);

  Future<bool> loginUser({@required String email, @required String password}) async {
    try {
      // Use firebase authentication to login user
      var credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim()
      ).catchError((e){
        // showing error
        ScaffoldMessenger.of(_context).hideCurrentSnackBar();
        ScaffoldMessenger.of(_context).showSnackBar(
            SnackBar(
                content:
                Text(e.toString().split("]")[1].substring(1))));
      });

      if (credentials.user == null){
        return Future.value(false);
      }
      // if user exist return true
      if (FirebaseAuth.instance.currentUser != null){
        return Future.value(true);
      }
      return Future.value(false);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}