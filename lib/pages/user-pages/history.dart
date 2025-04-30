import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/widgetstyle.dart';


// aw historyay user daibene
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>( 
          future: instance.collection('users').doc(user!.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Check if snapshot has data
            if (snapshot.hasData && snapshot.data != null) {
              Map<String, dynamic> data = snapshot.data!.data()!;
              List history = data['history'];

              if (history == null || history.isEmpty) {
                return Center(child: Text('No data available'));
              }

              // Reverse the history list to show the most recent orders at the top
              history = List.from(history.reversed);

              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> historyItem = history[index];
                  final record = history[index];
                  final timestamp = record['date'] as Timestamp?;
                  final date = timestamp?.toDate();
                  List<dynamic> itemList = historyItem['name'];
                  String total = historyItem['total'].toString();
                  final orderNumber = history.length -index;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FaIcon(
                                  Icons.shopping_basket,
                                  color: WidgetStyle.primary,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Order Number $orderNumber',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 20
                                              : 16,
                                      fontWeight: FontWeight.bold,
                                      color: WidgetStyle.primary),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: WidgetStyle.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Date of Order: ${date?.day}/${date?.month}/${date?.year}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 600
                                            ? 16
                                            : 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: List.generate(itemList.length, (i) {
                                Map<String, dynamic> item = itemList[i];
                                String itemName = item['name'] ?? '';
                                String itemPrice = item['price'].toString();
                                int quantity = item['quantity'];
                                String imageUrl = item['image'];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        imageUrl,
                                        width: 20,
                                        height: 10,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '$itemName - \$${itemPrice} x $quantity',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    600
                                                ? 16
                                                : 14, // Responsive
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.money,
                                  color: WidgetStyle.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Total: \$${total}',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 18
                                              : 16, // Responsive
                                      fontWeight: FontWeight.bold,
                                      color: WidgetStyle.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('No data found');
            }
          },
        ),
      ),
    );
  }
}
