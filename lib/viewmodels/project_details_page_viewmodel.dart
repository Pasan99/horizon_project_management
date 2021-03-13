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
  int colorsCounter = 0;

  List colors = [Colors.red, Colors.green, Colors.yellow, Colors.blue, Colors.grey, Colors.purpleAccent, Colors.cyanAccent, Colors.white70, Colors.amberAccent, Colors.yellowAccent];

  ProjectDetailsPageViewModel(this.project){
    getTasks();
  }

  void getTasks() {
    // get all tasks
    FirebaseFirestore.instance
        .collection('tasks')
        .where("projectId", isEqualTo: project.id)
        .get()
        .then((QuerySnapshot querySnapshot)
    {
      tasks = [];
      employees = [];
      // save retrieved task to array
      querySnapshot.docs.forEach((doc) {
        tasks.add(Task().toClass(doc.data()));
      });

      // add 'ALL' option to filter (filter task by employee)
      employees.add(new User(id: "ALL", name: "All"));
      currentSelectedEmployee = "ALL";

      // loop every task to find employee names
      for(var t in tasks){
        // if employee not exist in the array, add new entry and assign color for that employee
        if (employees == null || employees.length == 0 || employees.where((element) => element.id == t.assignee.id).isEmpty){
          t.assignee.color  = colors[colorsCounter];
          employees.add(t.assignee);
        }
        // if employee exist, use existing employee's color
        else{
          t.assignee.color  = employees.where((element) => element.id == t.assignee.id).first.color;
        }
        if (colorsCounter == 9){
          colorsCounter = 0;
        }
        colorsCounter++;
      }
      notifyListeners();
      print(employees.length);
      allTasks = tasks;
    });
  }

  void filterTasks(){
    // filter tasks by selected employee from the dropdown
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