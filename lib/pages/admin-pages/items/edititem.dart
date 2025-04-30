import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_shop/WidgetStyle.dart';

class EditItem extends StatefulWidget {
  final String itemId;
  final Map<String, dynamic> itemData;

  const EditItem({super.key, required this.itemId, required this.itemData});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final typeController = TextEditingController();
  final specController = TextEditingController();
  final imageController = TextEditingController();
  final isEnableController = TextEditingController();
  bool isEnable = true;

  String selectedBrand = 'Samsung';

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
  void initState() {
    super.initState();
    isEnable = widget.itemData['isEnable'] ?? true;
    nameController.text = widget.itemData['name'] ?? '';
    priceController.text = widget.itemData['price'].toString();
    typeController.text = widget.itemData['type'] ?? '';
    specController.text = widget.itemData['spec'] ?? '';
    imageController.text = widget.itemData['image'] ?? '';
    selectedBrand = widget.itemData['sharika'] ?? brands[0];
  }

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
                    suffixIcon: Icon(Icons.drive_file_rename_outline),
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
                      value!.isEmpty ? 'Enter a new name' : null,
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
                      value!.isEmpty ? 'Enter a new price' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: typeController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Type',
                    suffixIcon: Icon(Icons.category),
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
                      value!.isEmpty ? 'Enter a new type' : null,
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
                    suffixIcon: Icon(Icons.image_outlined),
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
                    suffixIcon: Icon(Icons.business_outlined),
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
                DropdownButtonFormField<String>(
                  value: isEnable ? 'Enable' : 'Disable',
                  items: ['Enable', 'Disable']
                      .map((option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      isEnable = value ==
                          'Enable'; // Update the isEnable state based on selection
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Item Status',
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
                      await FirebaseFirestore.instance
                          .collection('items')
                          .doc(widget.itemId)
                          .update({
                        'name': nameController.text.toUpperCase(),
                        'price': double.tryParse(priceController.text) ?? 0,
                        'type': typeController.text.toUpperCase(),
                        'spec': specController.text,
                        'image': imageController.text,
                        'sharika': selectedBrand,
                         'isenable': isEnable
                      });
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.save_as),
                  label: Text(
                    'Update Item',
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
