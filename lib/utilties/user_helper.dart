import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;


import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/user_model.dart';
import 'package:horizon_project_management/routes/router.gr.dart';

class UserHelper{
  static final UserHelper _userHelper = UserHelper._internal();
  User _user;
  User _oldUser;

  factory UserHelper() {
    return _userHelper;
  }

  UserHelper._internal();

  Future<User> getCurrentUser() async {
    if (_user != null && _user.id != null){
      return _user;
    }
    else{
      try {
        Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
        Auth.User user = auth.currentUser;
        FirebaseFirestore store = FirebaseFirestore.instance;
        QuerySnapshot snapshot = await store.collection("users")
            .where("id", isEqualTo: user.uid)
            .get();

        if (snapshot != null) {
          List<DocumentSnapshot> documents = snapshot.docs;
          if (documents != null && documents.length > 0) {
            _user = new User();
            DocumentSnapshot document = documents[0];
            _user = _user.toClass(document.data());
            _oldUser = _user;
          }
        }
      }
      catch (Exception){
        print(Exception.toString());
        return null;
      }
    }
    _oldUser = _user;
    return _user;
  }

  User getCachedUser(){
    return _oldUser;
  }

  Future<User> renewUser() async {
    _user = null;
    return await getCurrentUser();
  }


  Future<Auth.UserCredential> registerWithPassword(String email,String password) async{
    try {
      Auth.UserCredential userCredential = await Auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    } on Auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  void changePassword(String password) async{
    //Create an instance of the current user.
    Auth.User user =  Auth.FirebaseAuth.instance.currentUser;
   // Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;

    print(password);
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
  logout(BuildContext context) async {
    _user = null;
    _oldUser = null;
    await Auth.FirebaseAuth.instance.signOut();
    ExtendedNavigator.of(context).pop();

    ExtendedNavigator.of(context).push(Routes.loginPage);
  }
}

