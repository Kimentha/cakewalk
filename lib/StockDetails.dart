import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';

import 'PointOfSales.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class StockDetails extends StatefulWidget {
  const StockDetails({Key? key}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockPageStateState();
}

class _StockPageStateState extends State<StockDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  // Function to add a product to Firestore
  Future<void> addProduct() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: productPriceController,
                decoration: InputDecoration(labelText: 'Product Price'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firestore.collection('PRODUCT').add({
                    'Product_Name': productNameController.text,
                    'Product_Price': double.parse(productPriceController.text),
                  });
                  // Clear the text fields
                  productNameController.clear();
                  productPriceController.clear();
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error adding product: $e');
                }
              },
              child: Text('Add'),
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

  // Function to update a product in Firestore
  void updateProduct(String productId) async {
    // Replace 'productId' with the actual product ID to update
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: productPriceController,
                decoration: InputDecoration(labelText: 'Product Price'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firestore.collection('PRODUCT').doc(productId).update({
                    'Product_Name': productNameController.text,
                    'Product_Price': double.parse(productPriceController.text),
                  });
                  // Clear the text fields
                  productNameController.clear();
                  productPriceController.clear();
                  Navigator.of(context).pop();
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
  void deleteProduct(String productId) async {
    // Replace 'productId' with the actual product ID to delete
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firestore.collection('PRODUCT').doc(productId).delete();
                  Navigator.of(context).pop();
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
                    "Stock Details",
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
                          stream: FirebaseFirestore.instance.collection('PRODUCT').snapshots(),
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
                                final productName = productData['Product_Name'] as String;
                                final productPrice = productData['Product_Price'] as double;

                                return ListTile(
                                  title: Text(
                                    'Product Name: $productName',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  subtitle: Text('Product Price: \R${productPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.black)),
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
                        addProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(450, 65),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Add Product',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
                      ),
                    ),
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
                        updateProduct('productId');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(450, 65),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Update Product',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
                      ),
                    ),
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
                        deleteProduct('productId');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(450, 65),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Delete Product',
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
