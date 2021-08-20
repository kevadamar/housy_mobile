import 'dart:convert';

class RoleModel {
  String name;

  RoleModel({this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        name: json['name'],
      );
}
