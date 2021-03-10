import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon_project_management/models/project_model.dart';
import 'package:horizon_project_management/models/task_model.dart';
import 'package:horizon_project_management/models/user_model.dart';

class ProjectDetailsPageViewModel extends ChangeNotifier{
  List<Task> tasks;
  List<Task> allTasks;
  Project project;
  List<User> employees;
  String currentSelectedEmployee;

  List colors = [Colors.red, Colors.green, Colors.yellow, Colors.blue, Colors.grey, Colors.purpleAccent, Colors.cyanAccent];
  Random random = new Random();

  ProjectDetailsPageViewModel(this.project){
    getTasks();
  }

  void getTasks() {
    FirebaseFirestore.instance
        .collection('tasks')
        .where("projectId", isEqualTo: project.id)
        .get()
        .then((QuerySnapshot querySnapshot)
    {
      tasks = [];
      employees = [];
      querySnapshot.docs.forEach((doc) {
        tasks.add(Task().toClass(doc.data()));
      });

      employees.add(new User(id: "ALL", name: "All"));
      currentSelectedEmployee = "ALL";
      for(var t in tasks){
        if (employees == null || employees.length == 0 || employees.where((element) => element.id == t.assignee.id).isEmpty){
          t.assignee.color  = colors[random.nextInt(7)];
          employees.add(t.assignee);
        }
        else{
          t.assignee.color  = employees.where((element) => element.id == t.assignee.id).first.color;
        }
      }
      notifyListeners();
      print(employees.length);
      allTasks = tasks;
    });
  }

  void filterTasks(){
    if (allTasks != null){
      if (currentSelectedEmployee == "ALL"){
        tasks = allTasks;
      }
      else {
        tasks = allTasks.where((element) => element.assignee.id ==
            currentSelectedEmployee).toList();
      }
      notifyListeners();
    }
  }
}