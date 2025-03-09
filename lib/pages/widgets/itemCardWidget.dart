import 'package:tech_shop/model/buyItemModel.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:flutter/material.dart';


class ItemCardWidget extends StatefulWidget {
  buyItemModel item;
  final changenumberofitem;
  ItemCardWidget({super.key, required this.item, required this.changenumberofitem});

  @override
  State<ItemCardWidget> createState() => _ItemCardWidgetState();
}

class _ItemCardWidgetState extends State<ItemCardWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 140,
      child: Card(
        color: WidgetStyle.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: Row(
          children: [
            SizedBox(
                height: 130,
                width: size.width * 0.4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(35), right: Radius.circular(20)),
                  child: Image.asset(
                    widget.item.image,
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close))
                ]),
                Text(widget.item.name),
                Text('Price : \$${widget.item.price * widget.item.numberOfItem}'),
                Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                      color: WidgetStyle.yellow,
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (widget.item.numberOfItem > 1) {
                              widget.item.numberOfItem--;
                              widget.changenumberofitem(widget.item.numberOfItem);
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            Icons.remove,
                            color: WidgetStyle.white,
                          )),
                      Text(
                        widget.item.numberOfItem.toString(),
                        style: TextStyle(color: WidgetStyle.white),
                      ),
                      IconButton(
                          onPressed: () {
                            widget.item.numberOfItem++;
                            widget.changenumberofitem(widget.item.numberOfItem);
                            setState(() {});
                          },
                          icon: Icon(Icons.add, color: WidgetStyle.white)),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

