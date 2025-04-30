import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/widgetstyle.dart';

class UserHistory extends StatelessWidget {
  final String userId;
  final String userName;

  const UserHistory({super.key, required this.userId, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'Tech Shop',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future:
              FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No user data found'));
            }

            final userData = snapshot.data!.data()!;
            List history = userData['history'] ?? [];

            if (history.isEmpty) {
              return const Center(child: Text('No purchase history found'));
            }

            history = List.from(history.reversed);

            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];
                final timestamp = record['date'] as Timestamp?;
                final date = timestamp?.toDate();
                final items = record['name'] as List<dynamic>? ?? [];
                final total = record['total']?.toString() ?? '0';
                final orderNumber = history.length - index;

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
                              const SizedBox(width: 8),
                              Text(
                                'Order Number $orderNumber',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 20
                                          : 16,
                                  fontWeight: FontWeight.bold,
                                  color: WidgetStyle.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (date != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: WidgetStyle.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Date of Order: ${date.day}/${date.month}/${date.year}',
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
                          const SizedBox(height: 10),
                          Column(
                            children: List.generate(items.length, (i) {
                              final item = items[i];
                              final itemName = item['name'] ?? 'Unnamed Item';
                              final itemPrice =
                                  item['price']?.toString() ?? '0';
                              final quantity = item['quantity'] ?? 1;
                              final imageUrl = item['image'] ?? '';

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    imageUrl.isNotEmpty
                                        ? Image.network(
                                            imageUrl,
                                            width: 20,
                                            height: 10,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(Icons.shopping_bag),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '$itemName - \$${itemPrice} x $quantity',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? 16
                                              : 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.money,
                                color: WidgetStyle.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Total: \$${total}',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 18
                                          : 16,
                                  fontWeight: FontWeight.bold,
                                  color: WidgetStyle.primary,
                                ),
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
          },
        ),
      ),
    );
  }
}
