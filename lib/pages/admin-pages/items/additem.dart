import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/WidgetStyle.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final typeController = TextEditingController();
  final specController = TextEditingController();
  final imageController = TextEditingController();

  String selectedBrand = 'Gaming parts';

  final List<String> brands = [
    "Samsung",
    "Apple",
    "Xioame",
    "HP",
    "Lenovo",
    "Dell",
    "Acer",
    "Asus",
    "MSI",
    "Keyboard",
    "Mouse",
    "Headset",
    "Gaming parts",
    "Speaker"
  ];

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );

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
            'Add New Item',
            style: TextStyle(color: WidgetStyle.white),
          ),
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    suffixIcon: Icon(Icons.label_outline),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide:
                          BorderSide(color: WidgetStyle.primary, width: 2),
                    ),
                  ),
                  onChanged: (value) {
                    nameController.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: nameController.selection,
                    );
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Enter item name' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Price',
                    suffixIcon: Icon(Icons.attach_money),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide:
                          BorderSide(color: WidgetStyle.primary, width: 2),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter item price' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: typeController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Type',
                    suffixIcon: Icon(Icons.style),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide:
                          BorderSide(color: WidgetStyle.primary, width: 2),
                    ),
                  ),
                  onChanged: (value) {
                    typeController.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: typeController.selection,
                    );
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Enter item type' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: specController,
                  decoration: InputDecoration(
                    labelText: 'Specification',
                    suffixIcon: Icon(Icons.info_outline),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide:
                          BorderSide(color: WidgetStyle.primary, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: imageController,
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    suffixIcon: Icon(Icons.image_search_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide:
                          BorderSide(color: WidgetStyle.primary, width: 2),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter item image' : null,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedBrand,
                  items: brands
                      .map((brand) => DropdownMenuItem<String>(
                            value: brand,
                            child: Text(brand),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => selectedBrand = value!),
                  decoration: InputDecoration(
                    labelText: 'Brand',
                    suffixIcon: FaIcon(FontAwesomeIcons.tags),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 18),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide:
                          BorderSide(color: WidgetStyle.primary, width: 2),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter item brand' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    iconColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: WidgetStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String docId = nameController.text.trim().toUpperCase();

                      final itemsSnapshot = await FirebaseFirestore.instance
                          .collection('items')
                          .get();
                      int newItemId = itemsSnapshot.size + 2;
                      var newItem = {
                        'id': newItemId,
                        'isenable': true,
                        'name': docId,
                        'price': int.tryParse(priceController.text) ?? 0,
                        'type': typeController.text.toUpperCase(),
                        'spec': specController.text,
                        'image': imageController.text,
                        'sharika': selectedBrand,
                        'storage': 1
                      };

                      await FirebaseFirestore.instance
                          .collection('items')
                          .doc(docId)
                          .set(newItem);

                      print("Item added with ID: $newItemId and docId: $docId");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Item added successfully!"),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // dialogaka daxa
                                  Navigator.of(context)
                                      .pop(); // agaretawa page item settings
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  icon: Icon(Icons.add_box_outlined),
                  label: Text(
                    'Add Item',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
