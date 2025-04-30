import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Auth/login.dart';
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
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'Tech Shop',
            style: TextStyle(
              color: WidgetStyle.white,
            ),
          ),
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          actions: [
            SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 10,
            ),
          ],
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
                            const Text(
                              'Total Items',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              '${koygshtekalakan()}',
                              style: const TextStyle(fontSize: 17),
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
                            const Text(
                              'Total Amount',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: WidgetStyle.primary,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Icon(
                                size: 15,
                                Icons.attach_money_rounded,
                                color: WidgetStyle.white,
                              ),
                            ),
                            Text(
                              '${koygshtenrx()}',
                              style: const TextStyle(fontSize: 17),
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
                            const Text(
                              'Delivery fee',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: WidgetStyle.primary,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Icon(
                                size: 15,
                                Icons.attach_money_rounded,
                                color: WidgetStyle.white,
                              ),
                            ),
                            const Text(
                              '5',
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
                            const Text(
                              'Total Amount ',
                              style: TextStyle(fontSize: 17),
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: WidgetStyle.primary,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Icon(
                                size: 15,
                                Icons.money,
                                color: WidgetStyle.white,
                              ),
                            ),
                            Text(
                              '${koygshtenrx() + 5} ',
                              style: const TextStyle(fontSize: 17),
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
                            const Color(0xFF194a7a),
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
  onPressed: () async {
    // Check if the user is logged in
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      // If no user is logged in, show a login/signup prompt
      // Optionally, you could show a dialog or navigate to the login screen
      // Example: Show a simple dialog to inform the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Please log in'),
            content: Text('You need to log in to proceed with the checkout.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()), // Replace with your LoginPage widget
                  );
                },
                child: Text('Log in'),
              ),
            ],
          );
        },
      );
    } else {
      // If the user is logged in, proceed to the checkout page
      BottomNavigation.pageindex = 2;
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: const Text(
    'Add To Card',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
)

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
