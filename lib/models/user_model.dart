import 'package:dev_mobile/models/role_model.dart';

class UserModel {
  String fullname;
  String username;
  String email;
  RoleModel role;
  String imagePofile;
  String phoneNumber;
  String address;
  String gender;

  UserModel({
    this.address,
    this.email,
    this.fullname,
    this.gender,
    this.imagePofile,
    this.phoneNumber,
    this.role,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json['phone_number']);
    return UserModel(
      address: json['address'],
      email: json['email'],
      fullname: json['fullname'],
      gender: json['gender'],
      imagePofile: json['image_pofile'],
      phoneNumber: '0' + json['phone_number'],
      role: RoleModel.fromJson(json['listAs']),
      username: json['username'],
    );
  }
}
