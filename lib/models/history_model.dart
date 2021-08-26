import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/models/user_model.dart';
import 'package:dev_mobile/utils/constants.dart';

class HistoryModel {
  int id;
  DateTime checkin;
  DateTime checkout;
  int total;
  int status;
  String attachment;
  HouseModel house;
  UserModel user;
  String stringStatus;

  HistoryModel({
    this.id,
    this.checkin,
    this.checkout,
    this.total,
    this.status,
    this.house,
    this.attachment,
    this.user,
    this.stringStatus,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final checkinParse = parsingDate(json['checkin']);
    final checkoutParse = parsingDate(json['checkout']);
    return HistoryModel(
      id: json['id'],
      checkin: checkinParse,
      checkout: checkoutParse,
      house: HouseModel.fromJson(json['house']),
      total: json['total'],
      attachment: json['attachment'],
      stringStatus: statusString((json['status'])),
      status: json['status'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
