import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/models/user_model.dart';
import 'package:intl/intl.dart';

class EditProjectPageViewModel extends ChangeNotifier{
  Project project;
  List<User> managers;
  String currentSelectedManager;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "0");
  TextEditingController clientController = TextEditingController();

  EditProjectPageViewModel(this.project){
    getManagers();

    // update
    if (project != null) {
      costController = TextEditingController(text: project.cost.toString());
      endDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(project.endDate.toDate()));
      startDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(project.startDate.toDate()));
      clientController = TextEditingController(text: project.client);
      nameController = TextEditingController(text: project.name);
      currentSelectedManager = project.manager.id;
    }
  }

  void getManagers() {
    // getting all managers from firestore
    managers = [];
    FirebaseFirestore.instance
        .collection('users')
        .where("role", isEqualTo: RoleTypes.MANAGER)
        .get()
        .then((QuerySnapshot querySnapshot)
    {
      querySnapshot.docs.forEach((doc) {
        managers.add(User().toClass(doc.data()));
      });
      // updating the UI
      notifyListeners();
    });
  }
  
  Future<bool> saveProject() async {
    // Get Project Data from controllers (data entered by user)
    Project newProject = Project();
    newProject.client = clientController.text;
    newProject.name = nameController.text;
    DateTime startDate = new DateFormat("yyyy-MM-dd").parse(startDateController.text);
    newProject.startDate = Timestamp.fromDate(startDate);
    DateTime endDate = new DateFormat("yyyy-MM-dd").parse(endDateController.text);
    newProject.endDate = Timestamp.fromDate(endDate);
    newProject.cost = double.parse(costController.text);
    newProject.manager  = managers.where((element) => element.id == currentSelectedManager).first;

    // create unique key for document (this way documents will ordered by based on created date)
    int futureDate = new DateTime.utc(2100, 11, 9).microsecondsSinceEpoch.toInt();
    String uniqueId = (futureDate - new DateTime.now().microsecondsSinceEpoch.toInt()).toString();
    newProject.id = uniqueId;

    newProject.status = ProjectStatus.ONGOING;

    // set the project id if updating existing project
    if (project != null){
      newProject.id = project.id;
    }
    // Firestore document reference
    var reference = FirebaseFirestore.instance.collection('projects').doc(newProject.id);

    if (project != null){
      // edit project
      await reference.update(newProject.toMap());
    }
    else{
      // new project
      await reference.set(newProject.toMap());
    }
    return true;
  }
}