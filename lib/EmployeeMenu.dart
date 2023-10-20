import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';
import 'package:cakewalkweb/report.dart';
import 'EmployeeDetails.dart';
import 'PointOfSales.dart';
import 'SalesDetails.dart';
import 'StockDetails.dart';




class EmployeeMenu extends StatefulWidget {
  final String emp; // Add this line

  const EmployeeMenu ({Key? key, required this.emp}) : super(key: key);

  @override
  State<EmployeeMenu > createState() => EmployeeMenuState();
}
class EmployeeMenuState extends State<EmployeeMenu> {
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

          child: Center(
            child: Container(
              width: 600,
              height: 515,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white
              ),
              child: Column(

                  children: <Widget>[
                    SizedBox(height: 90),
                    Text(
                      "Welcome Employee",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 35,
                          color:ColourPalette.textColor
                      ),
                    ),

                    SizedBox(width: 150),
                    const SizedBox(height: 50),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  POS(emp: widget.emp),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(450, 65),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Text(
                              'Point Of Sales',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ] ),
            ),
          ),
        ),
      ),
    );
  }
}