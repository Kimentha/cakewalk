import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesDetails extends StatefulWidget {
  const SalesDetails({Key? key}) : super(key: key);

  @override
  State<SalesDetails> createState() => MenuPageState();
}

class MenuPageState extends State<SalesDetails> {
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
                    color: ColourPalette.textColor,
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
                    "Sales Details",
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('SALE').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black),);
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            final sales = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: sales.length,
                              itemBuilder: (context, index) {
                                final saleData = sales[index].data() as Map<String, dynamic>;
                                final saleTime = saleData['Sale_time'] as Timestamp;
                                final saleStatus = saleData['Sale_status'] as String;

                                return ListTile(
                                  title: Text(
                                    'Sale Time: ${saleTime.toDate()}',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  subtitle: Text('Sale Status: $saleStatus', style: TextStyle(color: Colors.black)),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
              // Rest of your buttons and UI elements
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
