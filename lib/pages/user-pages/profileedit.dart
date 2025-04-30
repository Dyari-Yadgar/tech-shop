import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/widgetstyle.dart';

class ProfEdit extends StatefulWidget {
  const ProfEdit({super.key});

  @override
  State<ProfEdit> createState() => _ProfEditState();
}

class _ProfEditState extends State<ProfEdit> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  GlobalKey<FormFieldState<String>> emailValid = GlobalKey();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore instance = FirebaseFirestore.instance;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter a new name',
                suffix: Icon(
                  Icons.person,
                  color: WidgetStyle.primary,
                ),
                border: OutlineInputBorder(),
                focusedBorder: Border(),
                enabledBorder: Border(),
                errorBorder: Border(),
                disabledBorder: Border(),
                focusedErrorBorder: Border(),
              ),
            ),
            SizedBox(height: 20),

          
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Enter a new location',
                suffix: FaIcon(
                  Icons.location_on,
                  color: WidgetStyle.primary,
                ),
                border: OutlineInputBorder(),
                focusedBorder: Border(),
                enabledBorder: Border(),
                errorBorder: Border(),
                disabledBorder: Border(),
                focusedErrorBorder: Border(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Enter a new phone number',
                suffix: Icon(
                  Icons.phone,
                  color: WidgetStyle.primary,
                ),
                border: OutlineInputBorder(),
                focusedBorder: Border(),
                enabledBorder: Border(),
                errorBorder: Border(),
                disabledBorder: Border(),
                focusedErrorBorder: Border(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () async {
                  final String newName = nameController.text.trim();
                  final String newLocation = locationController.text.trim();
                  final String newPhone = phoneController.text.trim();
                  final String uid = auth.currentUser!.uid;

                  if (newName.isEmpty &&
                      newLocation.isEmpty &&
                      newPhone.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                              "at least enter one field to update"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        );
                      },
                    );
                    return;
                  }

                  Map<String, dynamic> updatedData = {};

                  if (newName.isNotEmpty) updatedData['name'] = newName;
                  if (newLocation.isNotEmpty)
                    updatedData['location'] = newLocation;
                  if (newPhone.isNotEmpty) updatedData['phone'] = newPhone;

                  try {
                    await instance
                        .collection('users')
                        .doc(uid)
                        .update(updatedData);
                        Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Profile updated successfully!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("failed to update profile: $e"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        );
                      },
                    );
                  }
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: WidgetStyle.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Edit',
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  OutlineInputBorder Border() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: WidgetStyle.primary, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
