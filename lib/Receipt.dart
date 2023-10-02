import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';

import 'PointOfSales.dart';


class ReceiptItem extends StatelessWidget {
  final String itemName;
  final int itemQuantity;

  ReceiptItem({required this.itemName, required this.itemQuantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            'Quantity: $itemQuantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiptPage extends StatefulWidget {
  final Map<String, int> itemsAndQuantities;
  final int totalQuantity;

  const ReceiptPage({
    Key? key,
    required this.itemsAndQuantities,
    required this.totalQuantity, required double totalPrice,
  }) : super(key: key);

  @override
  State<ReceiptPage> createState() => ReceiptPageState();
}

class ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourPalette.backgroundColor,
      appBar: AppBar(
        // Your app bar code...
      ),
      body: Material(
        color: ColourPalette.backgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Text(
                  "Receipt",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    color: ColourPalette.textColor,
                  ),
                ),
                SizedBox(width: 160),
                const SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 500,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            itemCount: widget.itemsAndQuantities.length,
                            itemBuilder: (context, index) {
                              final itemName =
                              widget.itemsAndQuantities.keys.toList()[index];
                              final itemQuantity =
                              widget.itemsAndQuantities.values.toList()[index];

                              return ReceiptItem(
                                itemName: itemName,
                                itemQuantity: itemQuantity,
                              );
                            },
                            shrinkWrap: true,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Total Quantity: ${widget.totalQuantity}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ColourPalette.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
