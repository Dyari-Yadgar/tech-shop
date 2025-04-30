import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/model/itemmodel.dart';
import 'package:tech_shop/pages/user-pages/itemview.dart';
import 'package:tech_shop/WidgetStyle.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  TextEditingController search = TextEditingController();
  String sharika = '';
  String searchKey = '';
  String upperCaseValue = '';

  int selectedIndex = -1;
  List typeFilter = ['All', 'Price'];
  int selectedIndexType = 0;
  List<itemModel> data = [];
  List nameSharika = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 15),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: WidgetStyle.white,
                    borderRadius: BorderRadius.circular(17)),
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (context, reloadWidget) =>
                                filter(reloadWidget, nameSharika)),
                      );
                    },
                    icon: FaIcon(
                      Icons.filter_list_sharp,
                      size: 30,
                      color: WidgetStyle.primary,
                    )),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: search,
                    onChanged: (value) async {
                      upperCaseValue = value.toUpperCase();
                      search.value = search.value.copyWith(
                        text: upperCaseValue,
                        selection: TextSelection.collapsed(
                            offset: upperCaseValue.length),
                      );
                      if (upperCaseValue.isNotEmpty) {
                        searchKey = upperCaseValue;
                        setState(() {});
                      } else {
                        searchKey = '';
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'search',
                      hintTextDirection: TextDirection.rtl,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: const Color(0xffF1F1F1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, color: Color(0xffF1F1F1))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              width: 0, color: Color(0xffF1F1F1))),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 35,
            child: FutureBuilder(
                future: ref.child('sharika').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (!snapshot.data!.exists) {
                      return Text('No data available');
                    }
                    nameSharika =
                        snapshot.data!.children.map((e) => e.value).toList();

                    return ListView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        nameSharika.length,
                        (index) => Container(
                          padding: const EdgeInsets.only(right: 5),
                          child: ChoiceChip(
                            label: Text(
                              nameSharika[index],
                              style: TextStyle(color: WidgetStyle.primary),
                            ),
                            selected: selectedIndex == index ? true : false,
                            backgroundColor: WidgetStyle.white,
                            selectedColor: WidgetStyle.white,
                            side: BorderSide(
                                color: selectedIndex == index
                                    ? WidgetStyle.primary
                                    : WidgetStyle.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onSelected: (value) async {
                              if (index == selectedIndex) {
                                selectedIndex = -1;
                                setState(() {});
                              } else {
                                selectedIndex = index;

                                sharika = nameSharika[index];
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
              future: getData(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                data = snapshot.data!.docs
                    .map((e) => itemModel.fromJson(e.data()))
                    .toList();

                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40,
                    childAspectRatio: 0.75,
                    children: data.map((item) => itemCard(item)).toList(),
                  ),
                );
              }),
        ],
      ),
    ));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    if (selectedIndex == -1 && selectedIndexType == 0 && searchKey == '') {
      //default
      return instance.collection('items').get();
    } else if (selectedIndex != -1 &&
        selectedIndexType == 0 &&
        searchKey == '') {
      // bo sharika
      return instance
          .collection('items')
          .where('sharika', isEqualTo: sharika)
          .get();
    } else if (selectedIndex != -1 &&
        selectedIndexType != 0 &&
        searchKey == '') {
      return instance
          .collection('items')
          .orderBy(typeFilter[selectedIndexType] == 'Price' ? 'price' : 'storage')
          .where('sharika', isEqualTo: sharika)
          .get();
    } else if (selectedIndex == -1 &&
        selectedIndexType != 0 &&
        searchKey == '') {
      return instance
          .collection('items')
          .orderBy(typeFilter[selectedIndexType] == 'Price' ? 'price' : 'storage')
          .get();
    }
    // agar bas search bw
    else if (searchKey != '' && selectedIndex == -1 && selectedIndexType == 0) {
      return instance
          .collection('items')
          .where('name',
              isGreaterThanOrEqualTo: searchKey, isLessThan: searchKey + 'z')
          .get();
    }
    // aga search w sharika bwn
    else if (searchKey != '' && selectedIndex != -1 && selectedIndexType == 0) {
      return instance
          .collection('items')
          .where('sharika', isEqualTo: sharika)
          .where('name',
              isGreaterThanOrEqualTo: searchKey, isLessThan: searchKey + 'z')
          .get();
    }
    //agar search w rizkrdn bw

    return instance.collection('items').get();
  }

  Widget itemCard(itemModel item) {
    String storage = item.storage.toString();
    if (item.storage == 1024) {
      storage = '1TB';
    } else if (item.storage == 2048) {
      storage = '2TB';
    } else {
      storage = item.storage.toString() + 'GB';
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ItemView(item: item),
            ));
      },
      child: Column(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: NetworkImage(item.image), fit: BoxFit.cover)),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(25)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(25))),
                      height: 40,
                      width: double.infinity,
                      child: Text(
                        item.name,
                        style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text('Price :  \$${item.price}'),
        ],
      ),
    );
  }

  Widget filter(reloadWidget, List nameSharika) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: WidgetStyle.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      reloadWidget(() {
                        selectedIndexType = 0;
                        selectedIndex = -1;
                        searchKey = '';
                      });
                    });
                  },
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.black),
                  )),
              const Expanded(child: SizedBox()),
              const Text(
                'Filtering',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Filter By'),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    typeFilter.length,
                    (index) => InkWell(
                          onTap: () {
                            setState(() {
                              reloadWidget(() {
                                selectedIndexType = index;
                              });
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: index == typeFilter.length - 1 ? 0 : 10),
                            width: 100,
                            decoration: BoxDecoration(
                                color: selectedIndexType == index
                                    ? Colors.grey[900]
                                    : WidgetStyle.white,
                                border: Border.all(
                                    width: 1.5,
                                    color:
                                        const Color.fromARGB(255, 23, 22, 22)),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              '${typeFilter[index]}',
                              style: TextStyle(
                                  color: selectedIndexType == index
                                      ? WidgetStyle.white
                                      : Colors.grey[900],
                                  fontSize: 17),
                            ),
                          ),
                        ))),
          ),
          const SizedBox(height: 20),
          const Text('Brand Name'),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    nameSharika.length,
                    (index) => InkWell(
                          onTap: () async {
                            if (index == selectedIndex) {
                              selectedIndex = -1;
                              setState(() {
                                reloadWidget(() {});
                              });
                            } else {
                              selectedIndex = index;

                              sharika = nameSharika[index];
                              setState(() {
                                reloadWidget(() {});
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: index == nameSharika.length - 1 ? 0 : 10),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Colors.grey[900]
                                    : WidgetStyle.white,
                                border: Border.all(
                                    width: 1.5,
                                    color:
                                        const Color.fromARGB(255, 23, 22, 22)),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              nameSharika[index],
                              style: TextStyle(
                                  color: selectedIndex == index
                                      ? WidgetStyle.white
                                      : Colors.grey[900],
                                  fontSize: 17),
                            ),
                          ),
                        ))),
          )
        ],
      ),
    );
  }
}
