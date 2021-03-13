import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';

class OnHoldFragmentViewModel extends ChangeNotifier{
  List<Project> projects;
  OnHoldFragmentViewModel(){
    getProjects();
  }

  void getProjects() {
    FirebaseFirestore.instance
        .collection('projects')
        .where("status",isEqualTo: ProjectStatus.ONHOLD)
        .get()
        .then((QuerySnapshot querySnapshot)
          {
            projects = [];
            querySnapshot.docs.forEach((doc) {
              projects.add(Project().toClass(doc.data()));
            });
            notifyListeners();
          });
  }
}