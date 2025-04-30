import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';


import 'package:tech_shop/widgetstyle.dart';

class PCPart {
  String name;
  String type;
  double price;
  String spec;
  String brand;
  bool isEnable;
  String imageUrl; // Add image URL field

  PCPart({
    required this.name,
    required this.type,
    required this.price,
    required this.spec,
    required this.brand,
    required this.isEnable,
    required this.imageUrl, // Include image URL in constructor
  });

  // Factory method to create a PCPart from a Map (used for parsing CSV)
  factory PCPart.fromMap(Map<String, dynamic> data) {
    return PCPart(
      name: data['Name'],
      type: data['Type'],
      price: double.parse(data['Price']),
      spec: data['Spec'],
      brand: data['Brand'],
      isEnable: data['isEnable'] == 'true',
      imageUrl: data['Image'], // Retrieve image URL
    );
  }
}

class GuessPcBuildPage extends StatefulWidget {
  @override
  _GuessPcBuildPageState createState() => _GuessPcBuildPageState();
}

class _GuessPcBuildPageState extends State<GuessPcBuildPage> {
  late Future<List<PCPart>> futurePCParts;
  double budget = 0.0; // User-entered budget
  double totalCost = 0.0; // Total cost of the selected build
  List<PCPart> selectedParts = []; // List of selected parts for the build

  @override
  void initState() {
    super.initState();
    futurePCParts = loadPCParts(); // Load PC parts when the page is initialized
  }

  // Method to load PC parts from a CSV file
  Future<List<PCPart>> loadPCParts() async {
    final csvData = await rootBundle.loadString('assets/pc_parts_data.csv');
    List<List<dynamic>> rows = CsvToListConverter().convert(csvData);
    List<PCPart> parts = [];

    for (var row in rows.skip(1)) {
      Map<String, dynamic> partData = {
        'Name': row[1],
        'Type': row[2],
        'Price': row[3].toString(),
        'Spec': row[4],
        'Brand': row[5],
        'isEnable': row[6].toString(),
        'Image': row[7]
            .toString(), 
      };
      parts.add(PCPart.fromMap(partData));
    }
    return parts;
  }

  // Method to select the best build close to the user's budget
  void calculateBuild(List<PCPart> allParts) {
    if (budget <= 0 || budget <= 700) {
      return;
    }

    double closestTotalCost = 0.0;
    selectedParts.clear();

    // Categories
    List<String> categories = [
      'CPU',
      'GPU',
      'RAM',
      'HARD',
      'PSU',
      'COOLER',
      'CASE',
      'MB'
    ];

    // List to hold selected parts per category
    Map<String, PCPart?> selectedPartsPerCategory = {};

    // Sort parts by price to try and select the best combination
    allParts.sort((a, b) => a.price.compareTo(b.price));

    // List to store all valid combinations
    List<List<PCPart>> possibleCombinations = [];

    // Try to find a combination of parts from each category
    List<PCPart> cpuParts =
        allParts.where((part) => part.type == 'CPU').toList();
    List<PCPart> gpuParts =
        allParts.where((part) => part.type == 'GPU').toList();
    List<PCPart> ramParts =
        allParts.where((part) => part.type == 'RAM').toList();
    List<PCPart> hardParts =
        allParts.where((part) => part.type == 'HARD').toList();
    List<PCPart> psuParts =
        allParts.where((part) => part.type == 'PSU').toList();
    List<PCPart> coolerParts =
        allParts.where((part) => part.type == 'COOLER').toList();
    List<PCPart> caseParts =
        allParts.where((part) => part.type == 'CASE').toList();
    List<PCPart> mbParts = allParts.where((part) => part.type == 'MB').toList();

    // Nested loops to try every combination of parts from each category
    for (var cpu in cpuParts) {
      for (var gpu in gpuParts) {
        for (var ram in ramParts) {
          for (var hard in hardParts) {
            for (var psu in psuParts) {
              for (var cooler in coolerParts) {
                for (var casePart in caseParts) {
                  for (var mb in mbParts) {
                    double total = cpu.price +
                        gpu.price +
                        ram.price +
                        hard.price +
                        psu.price +
                        cooler.price +
                        casePart.price +
                        mb.price;

                    // If the total is within the budget and closer to the user's budget, select this combination
                    if (total <= budget && total > closestTotalCost) {
                      closestTotalCost = total;
                      selectedParts = [
                        cpu,
                        gpu,
                        ram,
                        hard,
                        psu,
                        cooler,
                        casePart,
                        mb
                      ];
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    totalCost = closestTotalCost;

    setState(() {}); // Trigger UI update
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
            SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: FutureBuilder<List<PCPart>>(
          future: futurePCParts, // The Future to display the list of PC parts
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No parts available'));
            } else {
              List<PCPart> parts = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your budget',
                        suffixIcon:
                            Icon(Icons.money_sharp, color: WidgetStyle.primary),
                        focusedBorder: Border(),
                        enabledBorder: Border(),
                        errorBorder: Border(),
                        disabledBorder: Border(),
                        focusedErrorBorder: Border(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        budget = double.tryParse(value) ?? 0.0;
                      },
                    ),
                    SizedBox(height: 10),
                    // Styled Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              WidgetStyle.primary, // Customize this
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          calculateBuild(parts);
                        },
                        child: Text(
                          'Calculate Build',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Display selected PC parts
                    Text(
                      'The PCs Start with Minimum 750\nSelected PC Parts (Total: \$${totalCost.toStringAsFixed(2)})',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedParts.length,
                        itemBuilder: (context, index) {
                          final part = selectedParts[index];
                          return ListTile(
                            leading: Image.network(part.imageUrl,
                                width: 40, height: 40), 
                            title: Text(part.name),
                            subtitle:
                                Text('\$${part.price.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  OutlineInputBorder Border() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: WidgetStyle.primary, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
