import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/models/user_model.dart';

class EmployeeFragmentViewModel extends ChangeNotifier{
  List<User> users;
  EmployeeFragmentViewModel(){
    getEmployees();
  }

  void getEmployees() {
    FirebaseFirestore.instance
        .collection('users')
         .where("role",isEqualTo:"EMPLOYEE")
        .get()
        .then((QuerySnapshot querySnapshot)
          {
            users = [];
            querySnapshot.docs.forEach((doc) {
              users.add(User().toClass(doc.data()));
            });
            notifyListeners();
          });
  }
}