import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_shop/WidgetStyle.dart'; // Assuming WidgetStyle is defined elsewhere

class PcBuild extends StatefulWidget {
  const PcBuild({super.key});

  @override
  _PcBuildState createState() => _PcBuildState();
}

class _PcBuildState extends State<PcBuild> {
  String? selectedCpu;
  String? selectedRam;
  String? selectedHardDrive;
  String? selectedPowerSupply;
  String? selectedGpu;
  String? selectedMotherboard;
  String? selectedCase;
  String? selectedCooler;
  bool showPriceSummary = false;

  List<Map<String, dynamic>> cpuItems = [];
  List<Map<String, dynamic>> ramItems = [];
  List<Map<String, dynamic>> hardDriveItems = [];
  List<Map<String, dynamic>> powerSupplyItems = [];
  List<Map<String, dynamic>> gpuItems = [];
  List<Map<String, dynamic>> motherboardItems = [];
  List<Map<String, dynamic>> caseItems = [];
  List<Map<String, dynamic>> coolerItems = [];


  Future<void> getItems(String type) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('items') 
        .where('type', isEqualTo: type) 
        .get();

    setState(() {
      if (type == 'CPU') {
        cpuItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'RAM') {
        ramItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'HARD') {
        hardDriveItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'PSU') {
        powerSupplyItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'GPU') {
        gpuItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'MB') {
        motherboardItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'CASE') {
        caseItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else if (type == 'COOLER') {
        coolerItems = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getItems('CPU');
    getItems('RAM');
    getItems('HARD');
    getItems('PSU');
    getItems('GPU');
    getItems('MB');
    getItems('CASE');
    getItems('COOLER');
  }

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
            SizedBox(width: 40),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
      
                buildDropdownRow('CPU', selectedCpu, cpuItems, (val) {
                  setState(() {
                    selectedCpu = val;
                  });
                }),
      
                buildDropdownRow('RAM', selectedRam, ramItems, (val) {
                  setState(() {
                    selectedRam = val;
                  });
                }),
      
                buildDropdownRow('Hard', selectedHardDrive, hardDriveItems,
                    (val) {
                  setState(() {
                    selectedHardDrive = val;
                  });
                }),
      
                buildDropdownRow(
                    'Power Supply', selectedPowerSupply, powerSupplyItems, (val) {
                  setState(() {
                    selectedPowerSupply = val;
                  });
                }),
      
                buildDropdownRow('GPU', selectedGpu, gpuItems, (val) {
                  setState(() {
                    selectedGpu = val;
                  });
                }),
      
                buildDropdownRow(
                    'Motherboard', selectedMotherboard, motherboardItems, (val) {
                  setState(() {
                    selectedMotherboard = val;
                  });
                }),
      
                buildDropdownRow('Case', selectedCase, caseItems, (val) {
                  setState(() {
                    selectedCase = val;
                  });
                }),
      
                buildDropdownRow('COOLER', selectedCooler, coolerItems, (val) {
                  setState(() {
                    selectedCooler = val;
                  });
                }),
      
                // Space between components
                SizedBox(height: 20),
      
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showPriceSummary) ...[
                      // Total Price
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.sackDollar,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Total: \$${calculateTotalPrice().toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
      
                      // Total with 4% Discount
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.percent,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Total with 4% Discount: \$${(calculateTotalPrice() * 0.96).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
      
                      // Compatibility Text
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: getCompatibilityText().contains("Bad")
                                ? Colors.red
                                : Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              getCompatibilityText(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: getCompatibilityText().contains("Bad")
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
      
                      SizedBox(height: 10),
                    ],
      
                    // Button to Build PC
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: WidgetStyle.primary,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showPriceSummary = true;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.screwdriverWrench,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Build Your PC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getCompatibilityText() {
    // Check if the selected CPU contains i5, i7, or i9
    if (selectedCpu?.contains('i5') == true &&
        (selectedMotherboard?.contains('B760') == true ||
            selectedMotherboard?.contains('Z790') == true ||
            selectedMotherboard?.contains('H610') == true)) {
      return 'Great compatibility. The motherboard is good enough for the CPU.';
    } else if (selectedCpu?.contains('i7') == true &&
        (selectedMotherboard?.contains('B760') == true ||
            selectedMotherboard?.contains('Z790') == true)) {
      return 'Great compatibility. The motherboard is good enough for the CPU.';
    } else if (selectedCpu?.contains('i9') == true &&
        selectedMotherboard?.contains('Z790') == true) {
      return 'Great compatibility. The motherboard is good enough for the CPU.';
    } else if (selectedCpu?.contains('i5') == true ||
        selectedCpu?.contains('i7') == true ||
        selectedCpu?.contains('i9') == true) {
      return 'Bad compatibility. The motherboard is not good enough for the CPU.';
    }
    return ''; // Default return value if no match
  }

  double calculateTotalPrice() {
    double total = 0;

    List<String?> selectedItems = [
      selectedCpu,
      selectedRam,
      selectedHardDrive,
      selectedPowerSupply,
      selectedGpu,
      selectedMotherboard,
      selectedCase,
      selectedCooler,
    ];

    List<List<Map<String, dynamic>>> itemLists = [
      cpuItems,
      ramItems,
      hardDriveItems,
      powerSupplyItems,
      gpuItems,
      motherboardItems,
      caseItems,
      coolerItems,
    ];

    for (int i = 0; i < selectedItems.length; i++) {
      final selectedName = selectedItems[i];
      final itemList = itemLists[i];

      if (selectedName != null) {
        final item = itemList.firstWhere(
          (item) => item['name'] == selectedName,
          orElse: () => {},
        );
        if (item.containsKey('price')) {
          total += (item['price'] as num).toDouble();
        }
      }
    }

    return total;
  }

  Widget buildDropdownRow(String hint, String? selectedValue,
      List<Map<String, dynamic>> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300, // Adjust width to keep things tidy
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue,
                hint: Text(hint),
                onChanged: onChanged,
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item['name'],
                    child: Row(
                      children: [
                        if (item['image'] != null)
                          Image.network(
                            item['image'],
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported, size: 40),
                          ),
                        SizedBox(width: 10),
                        Flexible(child: Text(item['name'])),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
