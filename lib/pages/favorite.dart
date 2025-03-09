import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Data/ItemData.dart';
import 'package:tech_shop/model/itemmodel.dart';
import 'package:tech_shop/pages/itemview.dart';
import 'package:tech_shop/WidgetStyle.dart';


class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tech Shop',
          style: TextStyle(
            color: WidgetStyle.white,
          ),
        ),
        backgroundColor: WidgetStyle.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 20),
        child: ItemData.favorites.isNotEmpty
            ? ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(ItemData.favorites.length,
                    (index) => favoriteItem(size, ItemData.favorites[index])),
              )
            : const Center(
                child: Text('No any Favorite'),
              ),
      ),
    ));
  }

  Widget favoriteItem(Size size, itemModel item) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ItemView(item: item),
          )),
      child: SizedBox(
        height: 130,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          color: WidgetStyle.white,
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.4,
                height: 130,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(35),right: Radius.circular(20)),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  ItemData.favorites.remove(item);
                                });
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    ),
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('${item.price}\$'),
                    Text(item.storage),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
