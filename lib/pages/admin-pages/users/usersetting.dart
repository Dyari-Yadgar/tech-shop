import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/pages/admin-pages/users/userhistory.dart';
import 'package:tech_shop/widgetstyle.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  TextEditingController searchController = TextEditingController();
  String search = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            body: Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        search = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintTextDirection: TextDirection.ltr,
                      prefix: const Icon(
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
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('no data available'));
                      }

                      final allUsers = snapshot.data!.docs;

                      final filteredUsers = allUsers.where((user) {
                        final role = user['role'] ?? 'user';
                        if (role == 'admin') return false; // Exclude admins

                        final name =
                            (user['name'] ?? '').toString().toLowerCase();
                        final phone =
                            (user['phone'] ?? '').toString().toLowerCase();
                        return name.contains(search) || phone.contains(search);
                      }).toList();

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            final name = user['name'] ?? 'No Name';
                            final phone = user['phone'] ?? 'No Phone';

                            return Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: WidgetStyle.primary,
                                  child: const Icon(Icons.person,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.phone,
                                        size: 16, color: WidgetStyle.primary),
                                    const SizedBox(width: 4),
                                    Text(phone),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: WidgetStyle.primary,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => UserHistory(
                                          userId: user.id,
                                          userName: name,
                                        ),
                                      ));
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
