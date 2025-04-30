class itemModel {
  late String name;
  late int price;
  late int id;
  late int storage;
  late String sharika;
  late String image;
  late String spec;

  itemModel({
    required this.name,
    required this.price,
    required this.id,
    required this.storage,
    required this.sharika,
    required this.image,
    required this.spec,
  });

  itemModel.fromJson(Map<String, dynamic> data) {
    spec = data['spec'] ?? '';
    id = data['id'] ?? 0;
    name = data['name'] ?? '';
    price = data['price'] ?? 0;
    storage = data['storage'] ?? 0;
    sharika = data['sharika'] ?? '';
    image = data['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'spec': spec,
      'id': id,
      'name': name,
      'price': price,
      'storage': storage,
      'sharika': sharika,
      'image': image,
    };
  }
}
