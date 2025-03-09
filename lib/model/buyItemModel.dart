
class buyItemModel {
  late String name;
  late int price;
  late String storage;
  late String sharika;
  late String image;

  late int numberOfItem;

  buyItemModel.fromJson(Map<String, dynamic> data) {
    //naw fromJson
    // ba map aegareneneawa
    name = data['name'];
    price = data['price'];
    storage = data['storage'];
    sharika = data['sharika'];
    image = data['image'];
    numberOfItem = data['numberOfItem'];
  }

  bool operator ==(Object other) {
    return other is buyItemModel &&
        other.name == name &&
        other.price == price &&
        other.storage == storage &&
        other.sharika == sharika &&
        other.image == image;
  }
}
