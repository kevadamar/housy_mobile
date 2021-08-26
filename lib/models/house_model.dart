import 'package:dev_mobile/models/city_model.dart';

class HouseModel {
  int id;
  String name;
  String address;
  int price;
  String description;
  String image;
  String imageFirst;
  String imageSecond;
  String imageThird;
  CityModel city;
  String bedroom;
  String bathroom;
  String area;
  String typeRent;

  HouseModel({
    this.id,
    this.name,
    this.address,
    this.price,
    this.description,
    this.image,
    this.imageFirst,
    this.imageSecond,
    this.imageThird,
    this.city,
    this.bedroom,
    this.bathroom,
    this.area,
    this.typeRent,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      price: json['price'] is String ? int.parse(json['price']) : json['price'],
      description: json['description'],
      image: json['image'],
      imageFirst: json['imageFirst'],
      imageSecond: json['imageSecond'],
      imageThird: json['imageThird'],
      city: CityModel.fromJson(json['city']),
      bedroom: json['bedroom'].toString(),
      bathroom: json['bathroom'].toString(),
      area: json['area'].toString(),
      typeRent: json['typeRent'],
    );
  }
}
