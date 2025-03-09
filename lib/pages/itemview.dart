import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Data/ItemData.dart';
import 'package:tech_shop/model/buyItemModel.dart';
import 'package:tech_shop/model/itemmodel.dart';
import 'package:tech_shop/pages/buy.dart';
import 'package:tech_shop/WidgetStyle.dart';


class ItemView extends StatefulWidget {
  final itemModel item;
  const ItemView({super.key, required this.item});
  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool isfavorite = false;
  int numberOfItem = 1;
  @override
  void initState() {

    super.initState();
    isfavorite = ItemData.checkItemFavorite(widget.item);
    ItemData.buyData.forEach((element) {
      if (element.name == widget.item.name && element.price== widget.item.price
      && element.sharika == widget.item.sharika) {
        numberOfItem = element.numberOfItem;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Container(
          height: size.height * 0.5,
          width: size.width,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(0)),
              image: DecorationImage(
                  image: AssetImage(widget.item.image), fit: BoxFit.cover)),
          child: Container(
              // ta jwt nabe ba shashakawa
              margin: const EdgeInsets.only(left: 10, top: 10),
              alignment: Alignment.center,
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 3),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: Colors.white,
                        ))),
              )),
        ),
        const SizedBox(
          height: 10,
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.item.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          const SizedBox(
            width: 35,
          ),
          Container(
            height: 40,
            width: 140,

            decoration: BoxDecoration(
                color: const Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (numberOfItem > 1) {
                          numberOfItem--;
                        }
                      });
                    },
                    icon: const Icon(Icons.remove, color: Color(0xff555555))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8), // bo baenean
                  child: Text(numberOfItem.toString(),
                      style: const TextStyle(
                          color: Color(0xff555555), fontSize: 20)),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        numberOfItem++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xff555555),
                    )),
              ],
            ),
          ),
          const Expanded(child: SizedBox()), //ta pey bkre halebdata awla
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text('${widget.item.price}', style: const TextStyle(fontSize: 18)),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [WidgetStyle.second, WidgetStyle.primary],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(7)),
            child: Icon(
              Icons.attach_money_rounded,
              color: WidgetStyle.white,
            ),
          ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text('${widget.item.price*numberOfItem}\$', style: const TextStyle(fontSize: 18)),
          const SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [WidgetStyle.second, WidgetStyle.primary],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(7)),
            child: Icon(
              Icons.money_rounded,
              color: WidgetStyle.white,
            ),
          ),
                ],
              )
            ],

          ),
          const SizedBox(
            width: 35,
          )
        ]),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.item.sharika,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              // rekrdnaway wshakan
              textAlign: TextAlign.end,
            ),
            const SizedBox(
              width: 35,
            )
          ],
        ),

        // buttonakan
        //
        //

        const Expanded(child: SizedBox()), // ta pey bkre yata xwarawa
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [const Color(0XffABA6E3), WidgetStyle.primary],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 0.1,
                          offset: const Offset(0, 2))
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        // true bw bekata false
                        if (!isfavorite) {
                          ItemData.favorites.add(widget.item);
                        } else {
                          ItemData.favorites.remove(widget.item);
                        }
                        isfavorite = !isfavorite;
                      });
                    },
                    icon: Icon(
                      isfavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_outlined,
                      color: Colors.white,
                    ))),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: size.width * 0.6,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color(0XffABA6E3), WidgetStyle.primary],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5, //talxe
                            spreadRadius: 0.1, //blawbwnawa
                            offset: const Offset(0, 2)) //offset shwenakayate
                      ]),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Buy(
                              item: buyItemModel.fromJson({
                                'name': widget.item.name,
                                'price': widget.item.price,
                                'storage': widget.item.storage,
                                'sharika': widget.item.sharika,
                                'image': widget.item.image,
                                'numberOfItem': numberOfItem
                              }),
                              changenumberofitem: (int number) {
                                setState(() {
                                  numberOfItem = number;
                                });
                              },
                            ),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        // yane be background
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text(
                      'کڕین',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ))
          ],
        ),
        
        const SizedBox(
          height: 20,
        )
      ],
    )
    )
    );
  }
}
