import 'dart:collection';
import 'package:horizon_project_management/models/base_model.dart';
import 'package:horizon_project_management/models/user_model.dart';

class Task extends BaseModel{
  String id;
  String description;
  String title;
  String status;
  User assignee;
  String projectId;

  Task({this.id, this.description, this.title, this.status, this.assignee,
      this.projectId});

  @override
  toClass(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.description = map["description"];
    this.status = map["status"];
    this.projectId = map["projectId"];
    this.assignee = User().toClass(map["assignee"]);
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new HashMap();
    map["id"] = this.id;
    map["title"] = this.title;
    map["description"] = this.description;
    map["status"] = this.status;
    map["projectId"] = this.projectId;
    map["assignee"] = this.assignee.toMap();
    return map;
  }


}