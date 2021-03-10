import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:horizon_project_management/models/base_model.dart';

class User extends BaseModel{
  String id;
  String name;
  String email;
  String contact;
  String role;
  Color color;

  User({this.id, this.name, this.email, this.contact, this.role});

  @override
  toClass(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.email = map["email"];
    this.contact = map["contact"];
    this.role = map["role"];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new HashMap();
    map["id"] = this.id;
    map["name"] = this.name;
    map["email"] = this.email;
    map["contact"] = this.contact;
    map["role"] = this.role;
    return map;
  }


}