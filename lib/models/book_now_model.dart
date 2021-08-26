class BookNowModel {
  int houseId;
  String houseImg;
  int price;

  BookNowModel({this.houseId, this.houseImg, this.price});

  factory BookNowModel.obj(int houseId, String houseImg, int price) {
    return BookNowModel(
      houseId: houseId,
      houseImg: houseImg,
      price: price,
    );
  }
}
