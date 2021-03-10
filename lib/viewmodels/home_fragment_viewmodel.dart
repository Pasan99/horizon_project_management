import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:horizon_project_management/models/project_model.dart';

class HomeFragmentViewModel extends ChangeNotifier{
  List<Project> projects;
  HomeFragmentViewModel(){
    getProjects();
  }

  void getProjects() {
    FirebaseFirestore.instance
        .collection('projects')
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