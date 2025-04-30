import 'package:tech_shop/model/buyItemModel.dart';
import 'package:tech_shop/model/itemmodel.dart';

class ItemData {
  static List<itemModel> data = [
    itemModel.fromJson({
      'image': 'assets/images/galaxy.jpg',
      'name': 'Samsoung galaxy 22 Ultra',
      'price': 950,
      'sharika': 'Samsung',
      'storage': '16TB',
    }),
    itemModel.fromJson({
      'image': 'assets/images/iphone.jpg',
      'name': 'Iphone 14 pro Max',
      'price': 900,
      'sharika': 'Apple',
      'storage': '1TB',
    }),
    itemModel.fromJson({
      'image': 'assets/images/redmi.jpg',
      'name': 'redmi note 10 pro',
      'price': 400,
      'sharika': 'Xioame',
      'storage': '256 GB',
    }),
  ];

  static List<int> favorites = [];

static bool checkItemFavorite(itemModel item) {
  return favorites.contains(item.id);
}


  static List<String> sharikaNames() {
    List<String> names = [];
    for (var element in ItemData.data) {
      if (!names.contains(element.sharika)) {
        names.add(element.sharika);
      }
    }
    return names;
  }

  static List<itemModel> sharikafiltter(int index) {
    if (index != -1) {
      String name = ItemData.sharikaNames()[index];
      return ItemData.data.where((element) => element.sharika == name).toList();
    } else {
      return ItemData.data;
    }
  }

  static List<itemModel> filtter(String type, int indexsharika) {
    if (type == 'price') {
      List<itemModel> sorted = List.from(sharikafiltter(indexsharika));
      sorted.sort(
        (a, b) => a.price.compareTo(b.price),
      );
      return sorted;
    } else {
      return List.from(sharikafiltter(indexsharika));
    }
  }

  static List<itemModel> search(String key, String type, int indexsharika) {
    if (key.isEmpty) {
      return List.from(filtter(type, indexsharika));
    } else {
      return filtter(type, indexsharika)
          .where((element) => element.name.toLowerCase().contains(key))
          .toList();
    }
  }

  static List<buyItemModel> buyData = [];
}
