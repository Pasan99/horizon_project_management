import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';

class ChangeStatusPageViewModel extends ChangeNotifier{
  Project project;
  String currentStatus = ProjectStatus.ONGOING;

  // Controllers
  TextEditingController onHoldReasonController = TextEditingController();

  ChangeStatusPageViewModel(this.project){
    // update
    if (project != null) {
      currentStatus = project.status;
      onHoldReasonController = TextEditingController(text: project.onHoldReason);
    }
  }


  Future<bool> saveProject() async {
    // Get Project Data from controllers (data entered by user)
    project.status = currentStatus;
    if (currentStatus == ProjectStatus.ONHOLD) {
      project.onHoldReason = onHoldReasonController.text;
    }

    // Firestore document reference
    var reference = FirebaseFirestore.instance.collection('projects').doc(project.id);
    await reference.update(project.toMap());
    return true;
  }
}