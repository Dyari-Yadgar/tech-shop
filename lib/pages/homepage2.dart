import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Data/ItemData.dart';
import 'package:tech_shop/model/itemmodel.dart';
import 'package:tech_shop/pages/itemview.dart';
import 'package:tech_shop/WidgetStyle.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int selecti = -1;
  List<String> typeFilter = ['All', 'Price', 'Storages'];
  int selectedIndexType = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final crossAxisCount = screenSize.width > 600 ? 3 : 2;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tech Shop',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          elevation: 4,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Search and Filter Row
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        context: context,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setState1) => filter(setState1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.menu_rounded, size: 28, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: WidgetStyle.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xffF1F1F1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Filter Chips
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ItemData.sharikaNames().length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(ItemData.sharikaNames()[index]),
                      selected: selecti == index,
                      backgroundColor: Colors.white,
                      selectedColor: WidgetStyle.primary,
                      labelStyle: TextStyle(
                        color: selecti == index ? Colors.white : WidgetStyle.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: WidgetStyle.primary),
                      ),
                      onSelected: (value) {
                        setState(() => selecti = selecti == index ? -1 : index);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Grid Items
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: ItemData.filtter(typeFilter[selectedIndexType], selecti).length,
                  itemBuilder: (context, index) => itemCard(
                    ItemData.filtter(typeFilter[selectedIndexType], selecti)[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 Widget filter(StateSetter setState1) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: BoxDecoration(
      color: WidgetStyle.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
    ),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min, // Ensures it takes only necessary space
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ),
        const Text('Sort By', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: List.generate(typeFilter.length, (index) {
            return ChoiceChip(
              label: Text(typeFilter[index]),
              selected: selectedIndexType == index,
              onSelected: (value) {
                setState(() {
                  setState1(() {
                    selectedIndexType = index;
                  });
                });
              },
            );
          }),
        ),
        const SizedBox(height: 20),
        const Text('Brand', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: List.generate(ItemData.sharikaNames().length, (index) {
            return ChoiceChip(
              label: Text(ItemData.sharikaNames()[index]),
              selected: selecti == index,
              onSelected: (value) {
                setState(() {
                  setState1(() {
                    selecti = selecti == index ? -1 : index;
                  });
                });
              },
            );
          }),
        ),
      ],
    ),
  );
}

  Widget itemCard(itemModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ItemView(item: item)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(item.image, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text('Price: \$${item.price}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                  Text('Size: ${item.storage}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
