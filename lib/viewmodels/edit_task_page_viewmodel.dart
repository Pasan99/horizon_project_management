import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/constants.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/models/task_model.dart';
import 'package:horizon_project_management/models/user_model.dart';

class EditTaskPageViewModel extends ChangeNotifier{
  final Task task;
  final Project project;
  List<User> employees;
  String currentSelectedAssignee;
  String currentSelectedStatus;
  List<String> statuses = [TaskStatus.ONGOING, TaskStatus.ONHOLD, TaskStatus.FINISHED, TaskStatus.CANCELLED,];

  // Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  EditTaskPageViewModel(this.task, this.project){
    getEmployees();

    if (task != null) {
      titleController = TextEditingController(text: task.title);
      descriptionController = TextEditingController(text: task.description);
      currentSelectedStatus = task.status;
      currentSelectedAssignee = task.assignee.id;
    }
  }

  void getEmployees() {
    employees = [];
    FirebaseFirestore.instance
        .collection('users')
        .where("role", isEqualTo: RoleTypes.EMPLOYEE)
        .get()
        .then((QuerySnapshot querySnapshot)
    {
      querySnapshot.docs.forEach((doc) {
        employees.add(User().toClass(doc.data()));
      });
      notifyListeners();
    });
  }

  Future<bool> saveTask() async {
    // Get Project Data
    Task newTask = Task();
    newTask.title = titleController.text;
    newTask.description = descriptionController.text;
    newTask.assignee  = employees.where((element) => element.id == currentSelectedAssignee).first;
    newTask.status = currentSelectedStatus;
    newTask.projectId = project.id;
    int futureDate = new DateTime.utc(2100, 11, 9).microsecondsSinceEpoch.toInt();
    String uniqueId = (futureDate - new DateTime.now().microsecondsSinceEpoch.toInt()).toString();
    newTask.id = uniqueId;
    if (task != null){
      newTask.id = task.id;
    }

    var reference = FirebaseFirestore.instance.collection('tasks').doc(newTask.id);

    if (task != null){
      // edit
      await reference.update(newTask.toMap());
    }
    else{
      // new
      await reference.set(newTask.toMap());
    }
    return true;
  }
}