import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:tech_shop/pages/admin-pages/items/edititem.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem({super.key});

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  TextEditingController search = TextEditingController();
  String searchKey = '';
  String upperCaseValue = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'Tech Shop',
            style: TextStyle(color: WidgetStyle.white),
          ),
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: search,
                  onChanged: (value) {
                    upperCaseValue = value.toUpperCase();
                    search.value = search.value.copyWith(
                      text: upperCaseValue,
                      selection: TextSelection.collapsed(
                          offset: upperCaseValue.length),
                    );
                    setState(() {
                      searchKey =
                          upperCaseValue.isNotEmpty ? upperCaseValue : '';
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xffF1F1F1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xffF1F1F1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, color: Color(0xffF1F1F1)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var docs = snapshot.data!.docs;

                  if (searchKey.isNotEmpty) {
                    docs = docs.where((doc) {
                      final name =
                          (doc['name'] as String?)?.toUpperCase() ?? '';
                      return name.contains(searchKey);
                    }).toList();
                  }

                  if (docs.isEmpty) {
                    return Center(child: Text('No item available.'));
                  }

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var data = docs[index].data() as Map<String, dynamic>;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              if ((data['image'] ?? '').toString().isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    data['image'],
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'] ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: WidgetStyle.primary),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['spec'] ?? '',
                                    ),
                                    Text(
                                      'Price: \$${data['price'] ?? ''}',
                                    ),
                                    Text(
                                      'Type: ${data['type'] ?? ''}',
                                    ),
                                    Text(
                                      'Brand: ${data['sharika'] ?? ''}',
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.settings,
                                          size: 35,
                                          color: WidgetStyle.primary,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => EditItem(
                                                itemId: docs[index].id,
                                                itemData: data,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
