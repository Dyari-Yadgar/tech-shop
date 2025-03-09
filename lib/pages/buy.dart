import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Data/ItemData.dart';
import 'package:tech_shop/main.dart';
import 'package:tech_shop/model/buyItemModel.dart';
import 'package:tech_shop/pages/widgets/itemCardWidget.dart';
import 'package:tech_shop/WidgetStyle.dart';


class Buy extends StatefulWidget {
  final changenumberofitem;
  final buyItemModel item;
  const Buy({super.key, required this.changenumberofitem, required this.item});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  void initState() {
    super.initState();
    if (!ItemData.buyData.contains(widget.item)) {
      ItemData.buyData.add(widget.item);
    } else {
      ItemData.buyData.forEach((element) {
        if (element.name == widget.item.name &&
            element.price == widget.item.price &&
            element.sharika == widget.item.sharika) {
          element.numberOfItem = widget.item.numberOfItem;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tech Shop',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: WidgetStyle.primary,
          // border radius la appbar
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                        ItemData.buyData.length,
                        (index) => ItemCardWidget(
                              item: ItemData.buyData[index],
                              changenumberofitem: (int number) {
                                if (widget.item == ItemData.buyData[index]) {
                                  setState(() {
                                    widget.changenumberofitem(number);
                                  });
                                }
                              },
                            ))),
              ),
              SizedBox(
                height: 230,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  color: WidgetStyle.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${koygshtekalakan()}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            const Text(
                              'Total Items',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${koygshtenrx()}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            const Text(
                              'Total Amount',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '5 \$',
                              style: TextStyle(fontSize: 17),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              'Delivery fee',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${koygshtenrx() + 5} \$',
                              style: const TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            const Text(
                              'Total Amount ',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: size.width * 0.6,
                  height: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0XffABA6E3),
                            WidgetStyle.primary
                          ],
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
                        BottomNavigation.pageindex = 2;
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => BottomNavigation()));
                      },
                      style: ElevatedButton.styleFrom(
                          // yane be background
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Text(
                        'Buy',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  int koygshtekalakan() {
    int all = 0;
    ItemData.buyData.forEach((element) {
      all += element.numberOfItem;
    });
    return all;
  }

  int koygshtenrx() {
    int all = 0;
    ItemData.buyData.forEach((element) {
      all += (element.numberOfItem * element.price);
    });
    return all;
  }
}
