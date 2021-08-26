import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/models/user_model.dart';
import 'package:dev_mobile/utils/constants.dart';

class BookingModel {
  int id;
  DateTime checkin;
  DateTime checkout;
  int total;
  String status;
  HouseModel house;
  UserModel user;

  BookingModel({
    this.id,
    this.checkin,
    this.checkout,
    this.total,
    this.status,
    this.house,
    this.user,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final checkinParse = parsingDate(json['checkin']);
    final checkoutParse = parsingDate(json['checkout']);
    return BookingModel(
      id: json['id'],
      checkin: checkinParse,
      checkout: checkoutParse,
      house: HouseModel.fromJson(json['house']),
      user: UserModel.fromJson(json['user']),
      total: json['total'] is int ? json['total'] : int.parse(json['total']),
      status: statusString((json['status'])),
    );
  }
}
