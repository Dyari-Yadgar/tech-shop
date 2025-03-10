import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Auth/login.dart';
import 'package:tech_shop/Data/ItemData.dart';
import 'package:tech_shop/pages/widgets/itemCardWidget.dart';
import 'package:tech_shop/WidgetStyle.dart';

class checkOut extends StatefulWidget {
  const checkOut({super.key});

  @override
  State<checkOut> createState() => _checkOutState();
}

class _checkOutState extends State<checkOut> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        body: ItemData.buyData.isEmpty
            ? Center(
                child: Text('No Any Data'),
              )
            : Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          children: List.generate(
                              ItemData.buyData.length,
                              (index) => ItemCardWidget(
                                    item: ItemData.buyData[index],
                                    changenumberofitem: (int number) {},
                                  ))),
                    ),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: WidgetStyle.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Define Yout Location',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 25,
                                  ),
                                  Text('sulaymaniah, Salm street',
                                      style: TextStyle(fontSize: 17))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: WidgetStyle.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${koygshtenrx() + 5} \$',
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  const Text(
                                    'Total ',
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
                                    offset: const Offset(
                                        0, 2)) //offset shwenakayate
                              ]),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Login()));
                            },
                            style: ElevatedButton.styleFrom(
                                // yane be background
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Text(
                              'کڕین',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
      )),
    );
  }

  int koygshtenrx() {
    int all = 0;
    for (var element in ItemData.buyData) {
      all += (element.numberOfItem * element.price);
    }
    return all;
  }
}
