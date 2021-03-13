import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
class EditEmployeePageViewModel extends ChangeNotifier{
  User user;
  List<User> employee;
  String currentSelectedEmployee;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController(text: "EMPLOYEE");


  EditEmployeePageViewModel(this.user){
    getEmployee();

    // update
    if (user != null) {
      emailController = TextEditingController(text: user.email.toString());
      contactController = TextEditingController(text: user.contact.toString());

      roleController = TextEditingController(text: user.role);
      nameController = TextEditingController(text: user.name);
      currentSelectedEmployee = user.id;
    }
  }

  void getEmployee() {
    employee = [];
    FirebaseFirestore.instance
        .collection('users')
        .where("role", isEqualTo: RoleTypes.EMPLOYEE)
        .get()
        .then((QuerySnapshot querySnapshot)
    {
      querySnapshot.docs.forEach((doc) {
        employee.add(User().toClass(doc.data()));
      });
      notifyListeners();
    });
  }

  Future<bool> saveUser(Auth.UserCredential userCredential) async {
    // Get Project Data
    User newUser = User();
    newUser.name = nameController.text;
    newUser.contact=contactController.text;
    newUser.role=roleController.text;
    newUser.email=emailController.text;

    newUser.role  =  roleController.text;

    int futureDate = new DateTime.utc(2100, 11, 9).microsecondsSinceEpoch.toInt();
    String uniqueId = (futureDate - new DateTime.now().microsecondsSinceEpoch.toInt()).toString();
    newUser.id = userCredential.user.uid;


    if (user != null){
      newUser.id = user.id;
    }

    var reference = FirebaseFirestore.instance.collection('users').doc(newUser.id);

    if (user != null){
      // edit
      await reference.update(newUser.toMap());
    }
    else{
      // new
      await reference.set(newUser.toMap());
    }
    return true;
  }
}