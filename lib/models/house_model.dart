class HouseModel {
  int id;
  String name;
  String address;
  String price;
  String description;
  String image;
  String city;
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
      price: json['price'],
      description: json['description'],
      image: json['image'],
      city: json['city']['name'],
      bedroom: json['bedroom'].toString(),
      bathroom: json['bathroom'].toString(),
      area: json['area'].toString(),
      typeRent: json['typeRent'],
    );
  }
}
