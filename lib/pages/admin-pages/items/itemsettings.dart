import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:tech_shop/pages/admin-pages/items/additem.dart';
import 'package:tech_shop/pages/admin-pages/items/updateitem.dart';

class ItemSettings extends StatefulWidget {
  const ItemSettings({super.key});

  @override
  State<ItemSettings> createState() => _ItemSettingsState();
}

class _ItemSettingsState extends State<ItemSettings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                'Tech Shop',
                style: TextStyle(
                  color: WidgetStyle.white,
                ),
              ),
              backgroundColor: WidgetStyle.primary,
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
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
            body: ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.25,
                  child: Image.asset('assets/images/logo.jpg'),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65,
                        width: 300,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                        decoration: BoxDecoration(
                          color: WidgetStyle.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => UpdateItem()),
                                );
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => UpdateItem()),
                                );
                              },
                              style: TextButton.styleFrom(
                                iconColor: Colors.white,
                              ),
                              child: Text(
                                'Edit Items',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65,
                        width: 300,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                        decoration: BoxDecoration(
                          color: WidgetStyle.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddItem()),
                                );
                              },
                              icon: FaIcon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddItem()),
                                );
                              },
                              style: TextButton.styleFrom(
                                iconColor: Colors.white,
                              ),
                              child: Text(
                                'Add an Item',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
