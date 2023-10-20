import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';

import 'PointOfSales.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SaleItem extends StatefulWidget {
  const SaleItem({Key? key}) : super(key: key);

  @override
  State<SaleItem> createState() => SaleItemState();
}

class SaleItemState extends State<SaleItem> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  // Function to add a product to Firestore



  // Function to update a product in Firestore
  void updateProduct() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Sale Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: productPriceController,
                decoration: InputDecoration(labelText: 'Product Quantity'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  String productName = productNameController.text;
                  if (productName.isNotEmpty) {
                    // Use the product name from the controller to update the specific product
                    await _firestore.collection('PRODUCT').where('Product_Name', isEqualTo: productName).get().then((querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        doc.reference.update({
                          'Product_Name': productName,
                          'Product_Price': double.parse(productPriceController.text),
                        });
                      });
                    });

                    // Clear the text fields
                    productNameController.clear();
                    productPriceController.clear();
                    Navigator.of(context).pop();
                  } else {
                    // Show an error or inform the user that the product name is required.
                  }
                } catch (e) {
                  print('Error updating product: $e');
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  // Function to delete a product from Firestore
  void deleteProduct() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: productNameC,
                decoration: InputDecoration(labelText: 'Product Name you want to delete'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  String productNameToDelete = productNameC.text;
                  if (productNameToDelete.isNotEmpty) {
                    // Use the product name from the controller to delete the specific product
                    await _firestore.collection('PRODUCT').where('Product_Name', isEqualTo: productNameToDelete).get().then((querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        doc.reference.delete();
                      });
                    });
                    Navigator.of(context).pop();
                  } else {
                    // Show an error or inform the user that the product name is required.
                  }
                } catch (e) {
                  print('Error deleting product: $e');
                }
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
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
                        color: ColourPalette.textColor
                    ),
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
                image: AssetImage('assets/images/pink.png'), // Replace with the actual path to your image
                fit: BoxFit.cover,
              ),
            ),

            child: SingleChildScrollView(
              child: Center(
                child: Column(

                  children: <Widget>[
                    SizedBox(height: 80),
                    Text(
                      "Sale Item Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 35,
                          color: ColourPalette.textColor
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
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('SALE_ITEM').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black));
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              final products = snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final productData = products[index].data() as Map<String, dynamic>;
                                  final productName = productData['Product'] as String;
                                  final productPrice = productData['Product_Quantity'] as double;

                                  return ListTile(
                                    title: Text(
                                      'Product Name: $productName',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    subtitle: Text('Product Quantity: productPrice', style: TextStyle(color: Colors.black)),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    DecoratedBox(
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
                        onPressed: () {
                          updateProduct();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(450, 65),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Update Sale Item',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
