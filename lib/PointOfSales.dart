import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class POS extends StatefulWidget {
  final String emp;

  POS({Key? key, required this.emp}) : super(key: key);

  @override
  State<POS> createState() => POSState();
}
class POSState extends State<POS> {

  List<String> productNames = [];
  final _itemNameController = TextEditingController();
  final _itemQuantityController = TextEditingController();
  Map<String?, int> itemsAndQuantities = {};
  String? ItemName = ""; // Initialize with an empty string



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemQuantityController.dispose();
    super.dispose();
  }

  Future<Map<String, int>> getItemPrices(String itemName) async {
    Map<String, int> prices = {};

    // Query the Firestore collection to get item prices based on the item name
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('PRODUCT').where('Product', isEqualTo: itemName).get();

    // Loop through the query results to extract prices
    querySnapshot.docs.forEach((doc) {
      prices[doc['Product']] = doc['Price']; // Assuming price field name is 'Price'
    });

    return prices;
  }
  ///gets values from text boxes

  String? getItemName() {
    return ItemName;
  }
  Future<void> readItems() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference collection = FirebaseFirestore.instance.collection('PRODUCT');

      // Fetch all documents in the collection
      QuerySnapshot querySnapshot = await collection.get();

      // Initialize a list to store the product names


      // Loop through the documents and extract the "items" field
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Access the data as a Map
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('Product_Name')) {
          // Access the "Product_Name" field as a String
          String productName = data['Product_Name'] as String;

          // Add the product name to the list
          productNames.add(productName);
        }

      }

    } catch (e) {
      print('Error reading product names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColourPalette.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: ColourPalette.backgroundColor,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/cakewalk.jpg',
                  width: 110,
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Cakewalk",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: ColourPalette.textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Material(
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pink.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 750,
                    height: 1000,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 8),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                'Point Of Sales',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: ColourPalette.textColor),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: 600,
                                child: FutureBuilder<void>(
                                  future: readItems(),
                                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      // Loading indicator or placeholder
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      // Handle error
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return DropdownButtonFormField<String>(
                                        style: TextStyle(color: Colors.black), // Text color
                                        dropdownColor: Colors.white, // Background color
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.all(27),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: ColourPalette.borderColor,
                                              width: 3,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: ColourPalette.gradient2,
                                              width: 3,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          hintText: 'Select Item',
                                          hintStyle: TextStyle(color: ColourPalette.textColor),

                                        ),


                                          value: productNames.contains(ItemName) ? ItemName : null,
                                        items: productNames.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(fontSize: 17, color: ColourPalette.textColor),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            ItemName = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Select Item";
                                          }
                                          return null;
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),


                            const SizedBox(width: 15),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: SizedBox(
                                width: 400,
                                child: TextFormField(
                                  controller: _itemQuantityController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(27),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: ColourPalette.borderColor,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: ColourPalette.gradient2,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: 'Enter Quantity',
                                    hintStyle: TextStyle(color: ColourPalette.textColor),
                                  ),
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (value) {},
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Container(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColourPalette.gradient1,
                                      ColourPalette.gradient2,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final itemQuantity = int.parse(_itemQuantityController.text);

                                    setState(() {
                                      itemsAndQuantities[ItemName] = itemQuantity;
                                    });
                                    await FirebaseFirestore.instance.collection('SALE_ITEM').add({
                                      'Product': ItemName,
                                      'Product_Quantity': itemQuantity,

                                    });
                                    // Clear the text fields
                                    _itemNameController.clear();
                                    _itemQuantityController.clear();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(200, 48),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Add Item',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColourPalette.gradient1,
                                      ColourPalette.gradient2,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final itemNameToDelete = _itemNameController.text;

                                    setState(() {
                                      itemsAndQuantities.remove(itemNameToDelete);
                                    });

                                    // Clear the text fields
                                    _itemNameController.clear();
                                    _itemQuantityController.clear();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(200, 48),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Remove Item',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 500,
                              height: 180,
                              decoration: BoxDecoration(
                                color: ColourPalette.backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListView.builder(
                                itemCount: itemsAndQuantities.length,
                                itemBuilder: (context, index) {
                                  //final itemName = itemsAndQuantities.keys.toList()[index];
                                  final itemQuantity = itemsAndQuantities.values.toList()[index];

                                  return ListTile(
                                    title: Text(ItemName!),
                                    subtitle: Text('Quantity: $itemQuantity'),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    ColourPalette.gradient1,
                                    ColourPalette.gradient3,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final itemName = _itemNameController.text;
                                  final itemQuantity = int.parse(_itemQuantityController.text);

                                  // Fetch item prices
                                  Map<String, double> itemPrices = (await getItemPrices(itemName)).cast<String, double>();

                                  setState(() {
                                    itemsAndQuantities[itemName] = itemQuantity;
                                  });

                                  // Calculate total price
                                  double totalPrice = itemPrices[itemName] != null ? itemPrices[itemName]! * itemQuantity : 0;

                                  // Assuming you have a "sales" collection to record sales
                                  final saleData = {
                                    'Sale_time': FieldValue.serverTimestamp(),
                                    'Sale_status': 'Completed',
                                    'Emp_ID': widget.emp,
                                    // Include the Sale_ID in your data
                                    'Sale_ID': null, // Leave it null for Firestore to auto-generate
                                    // Other sale-related data like customer information, total price, etc.
                                  };

                                  // Create a new sale document in Firestore
                                  final saleDocRef =
                                  await FirebaseFirestore.instance.collection('SALE').add(saleData);

                                  // Retrieve the automatically generated Sale_ID
                                  final saleId = saleDocRef.id;

                                  // Update the sale data with the Sale_ID
                                  saleData['Sale_ID'] = saleId;

                                  // Calculate the total quantity
                                  int totalQuantity = 0;
                                  itemsAndQuantities.forEach((itemName, itemQuantity) {
                                    totalQuantity += itemQuantity;
                                  });

                                  // Show a toast message with the total price
                                  Fluttertoast.showToast(
                                    msg: 'Total Price: \$${totalPrice.toStringAsFixed(2)}', // Format the total price as needed
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );

                                  // You can choose whether or not to navigate to another page after showing the message.
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ReceiptPage(
                                  //       itemsAndQuantities: itemsAndQuantities,
                                  //       totalQuantity: totalQuantity,
                                  //       totalPrice: totalPrice,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(400, 50),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: const Text(
                                  'Process Sale',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}


class NavItem extends StatelessWidget {
  const NavItem({
    required Key key,
    required this.title,
    required this.tapEvent,
  }) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title,
          style: TextStyle(
              color: ColourPalette.whiteColor,
              fontWeight: FontWeight.w300,
              fontSize: 18),
        ),
      ),
    );
  }
}