// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/model/itemmodel.dart';
import 'package:tech_shop/pages/user-pages/itemview.dart';
import 'package:tech_shop/WidgetStyle.dart';

class favorite extends StatefulWidget {
  const favorite({super.key});

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<int> favoriteIds = []; // favoritakan ba listek aheninawa bo pageaka
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
            await instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          List<dynamic> favorites = userDoc['favorites'] ?? [];
          setState(() {
            favoriteIds = List<int>.from(favorites);
            isLoading = false;
          });
        }
      } catch (e) {
        print('datay fav nahenetawa: $e');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : favoriteIds.isNotEmpty
                  ? FutureBuilder(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text("No favorite items"));
                        }
                        List<itemModel> data = snapshot.data!.docs
                            .map((e) => itemModel.fromJson(e.data()))
                            .toList();
                        return ListView(
                          scrollDirection: Axis.vertical,
                          children: List.generate(data.length,
                              (index) => favoriteItem(size, data[index])),
                        );
                      },
                    )
                  : const Center(child: Text('No favorite items available')),
        ),
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() {
    return instance.collection('items').where('id', whereIn: favoriteIds).get();
  }

  Widget favoriteItem(Size size, itemModel item) {
    String spec = item.spec;

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
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(35), right: Radius.circular(20)),
                  child: Image.network(
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
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  favoriteIds.remove(item.id);
                                });
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .update({
                                    'favorites':
                                        FieldValue.arrayRemove([item.id]),
                                  });
                                }
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
                    Expanded(child: SizedBox(height: 300, child: Text(spec))),
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
