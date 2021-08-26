class CityModel {
  int id;
  String name;

  CityModel({this.id, this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(id: json['id'], name: json['name']);
}
