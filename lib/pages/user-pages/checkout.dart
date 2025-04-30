import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool isLogin = false;
  FirebaseFirestore instance = FirebaseFirestore.instance;

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLogin = pref.getBool('isLogin') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your current Location',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 25,
                                        color: WidgetStyle.primary,
                                      ),
                                      FutureBuilder<DocumentSnapshot>(
                                        future: FirebaseAuth
                                                    .instance.currentUser !=
                                                null
                                            ? FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get()
                                            : Future.value(null),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData ||
                                              snapshot.data == null) {
                                            return Text(
                                              ' ',
                                              style: TextStyle(fontSize: 17),
                                            );
                                          }

                                          final data = snapshot.data!.data()
                                              as Map<String, dynamic>?;
                                          final location = data?['location'];

                                          return Text(
                                            location != null &&
                                                    location
                                                        .toString()
                                                        .trim()
                                                        .isNotEmpty
                                                ? location
                                                : ' ',
                                            style: TextStyle(fontSize: 17),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
                                  const Text(
                                    'Total ',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        color: WidgetStyle.primary,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: FaIcon(
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
                                    offset: const Offset(
                                        0, 2)) //offset shwenakayate
                              ]),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (FirebaseAuth.instance.currentUser != null) {
                                User? user = FirebaseAuth.instance.currentUser;

                                await instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .get()
                                    .then((value) async {
                                  List history = value.data()!['history'];
                                  history.add({
                                    'name': ItemData.buyData
                                        .map((e) => {
                                              'name': e.name,
                                              'price': e.price,
                                              'quantity': e.numberOfItem,
                                              'image': e.image
                                            })
                                        .toList(),
                                    'total': koygshtenrx(),
                                    'date': DateTime.now(),
                                  });
                                  await instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .update({'history': history});
                                });
                                ItemData.buyData.clear();
                                setState(() {});
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    bool ifCashSelected = false;
                                    bool ifCreditCardSelected = false;
                                    bool ifFIBSelected = false;
                                    bool ifFastpaySelected = false;
                                    bool ifQCardSelected = false;
                                    bool canPay = false;

                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return AlertDialog(
                                          title: Text('Select Payment Method'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Cash Checkbox
                                              CheckboxListTile(
                                                title: Text('Cash'),
                                                value: ifCashSelected,
                                                onChanged: ifCreditCardSelected
                                                    ? null
                                                    : (bool? value) {
                                                        setState(() {
                                                          ifCashSelected =
                                                              value ?? false;
                                                          if (ifCashSelected) {
                                                            ifCreditCardSelected =
                                                                false;
                                                          }
                                                          canPay =
                                                              ifCashSelected;
                                                        });
                                                      },
                                              ),
                                              // Credit Card Checkbox
                                              CheckboxListTile(
                                                title: Text('Credit Card'),
                                                value: ifCreditCardSelected,
                                                onChanged: ifCashSelected
                                                    ? null
                                                    : (bool? value) {
                                                        setState(() {
                                                          ifCreditCardSelected =
                                                              value ?? false;
                                                          if (ifCreditCardSelected) {
                                                            ifCashSelected =
                                                                false;
                                                          }

                                                          canPay =
                                                              ifCreditCardSelected
                                                                  ? false
                                                                  : canPay;
                                                        });
                                                      },
                                              ),
                                              // Nested checkboxes visible only if Credit Card is selected (but all will be disabled for now)
                                              if (ifCreditCardSelected) ...[
                                                CheckboxListTile(
                                                  title: Text('Payment by FIB'),
                                                  value: ifFIBSelected,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      ifFIBSelected =
                                                          value ?? false;
                                                    });
                                                  },
                                                  enabled:
                                                      false, // Disable this checkbox for now
                                                ),
                                                CheckboxListTile(
                                                  title: Text(
                                                      'Payment by Fastpay'),
                                                  value: ifFastpaySelected,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      ifFastpaySelected =
                                                          value ?? false;
                                                    });
                                                  },
                                                  enabled:
                                                      false, // Disable this checkbox for now
                                                ),
                                                CheckboxListTile(
                                                  title:
                                                      Text('Payment by QCard'),
                                                  value: ifQCardSelected,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      ifQCardSelected =
                                                          value ?? false;
                                                    });
                                                  },
                                                  enabled:
                                                      false, // Disable this checkbox for now
                                                ),
                                              ],
                                            ],
                                          ),
                                          actions: [
                                            Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: WidgetStyle.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: TextButton(
                                                  onPressed: canPay
                                                      ? () {
                                                          Navigator.pop(
                                                              context);
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Purchase Successful'),
                                                                content: Text(
                                                                  ifCashSelected
                                                                      ? 'Your purchase was successful! Payment method: Cash'
                                                                      : '',
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child: Text(
                                                                        'OK'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                      : null,
                                                  child: Text(
                                                    'Pay',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (!canPay)
                                              Text(
                                                'Please select a payment method before Paying.',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Login()),
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
                              'Buy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
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
