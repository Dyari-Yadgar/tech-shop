import 'package:tech_shop/model/buyItemModel.dart';
import 'package:tech_shop/model/itemmodel.dart';


class ItemData {
  static List<itemModel> data = [
    itemModel.fromJson({
      'name': 'Samsoung galaxy 23 Ultra',
      'price': 950,
      'storage': '1TB',
      'sharika': 'Samsung',
      'image': 'assets/images/galaxy.jpg'
    }),
    itemModel.fromJson({
      'name': 'Iphone 14 pro Max',
      'price': 900,
      'storage': '1TB',
      'sharika': 'Apple',
      'image': 'assets/images/iphone.jpg'
    }),
    itemModel.fromJson({
      'name': 'redmi note 10 pro',
      'price': 400,
      'storage': '256 GB',
      'sharika': 'Xioame',
      'image': 'assets/images/redmi.jpg'
    }),
  ];

  static List<itemModel> favorites = [];

  static bool checkItemFavorite(itemModel item) {
    bool r = false;
    for (var element in favorites) {
      if (element == item) {
        r = true;
      }
    }
    return r;
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
    if (type == 'Price') {
      List<itemModel> sorted = List.from(sharikafiltter(indexsharika));
      sorted.sort(
        (a, b) => a.price.compareTo(b.price),
      );
      return sorted;
    } else {
      return List.from(sharikafiltter(indexsharika));
    }
  }

  static List<buyItemModel> buyData = [];
}
