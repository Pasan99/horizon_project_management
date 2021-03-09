import 'package:horizon_project_management/models/base_model.dart';

class User extends BaseModel{
  String id;
  String name;
  String email;
  String contact;

  User({this.id, this.name, this.email, this.contact});

  @override
  toClass(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["nameSi"];
    this.email = map["nameEn"];
    this.contact = map["image"];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }


}