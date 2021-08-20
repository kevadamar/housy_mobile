import 'package:dev_mobile/models/house_model.dart';
import 'package:dev_mobile/utils/constants.dart';

class HistoryModel {
  DateTime checkin;
  DateTime checkout;
  int total;
  String status;
  String attachment;
  HouseModel house;

  HistoryModel({
    this.checkin,
    this.checkout,
    this.total,
    this.status,
    this.house,
    this.attachment,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final checkinParse = parsingDate(json['checkin']);
    final checkoutParse = parsingDate(json['checkout']);
    return HistoryModel(
      checkin: checkinParse,
      checkout: checkoutParse,
      house: HouseModel.fromJson(json['house']),
      total: json['total'],
      attachment: json['attachment'],
      status: statusString((json['status'])),
    );
  }
}
