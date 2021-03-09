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
            .where("userId", isEqualTo: user.uid)
            .get();

        if (snapshot != null) {
          List<DocumentSnapshot> documents = snapshot.docs;
          if (documents != null && documents.length > 0) {
            _user = new User();
            DocumentSnapshot document = documents[0];
            _user = _user.toClass(document.data());

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

  logout(BuildContext context) async {
    _user = null;
    _oldUser = null;
    await Auth.FirebaseAuth.instance.signOut();
    ExtendedNavigator.of(context).pop();
    ExtendedNavigator.of(context).pop();
    ExtendedNavigator.of(context).push(Routes.loginPage);
  }
}