import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon_project_management/models/base_model.dart';
import 'package:horizon_project_management/models/user_model.dart';

class Project extends BaseModel{
  String id;
  String name;
  String client;
  double cost;
  Timestamp endDate;
  Timestamp startDate;
  String onHoldReason;
  String status;
  User manager;

  Project({this.id, this.name, this.client, this.cost, this.endDate, this.startDate, this.onHoldReason, this.status, this.manager});

  @override
  toClass(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.client = map["client"];
    this.cost = map["cost"];
    this.endDate = map["endDate"];
    this.startDate = map["startDate"];
    this.onHoldReason = map["onHoldReason"];
    this.status = map["status"];
    this.manager = User().toClass(map["manager"]);
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new HashMap();
    map["id"] = this.id;
    map["name"] = this.name;
    map["client"] = this.client;
    map["cost"] = this.cost;
    map["endDate"] = this.endDate;
    map["startDate"] = this.startDate;
    map["manager"] = this.manager.toMap();
    map["onHoldReason"] = this.onHoldReason;
    map["status"] = this.status;
    return map;
  }


}