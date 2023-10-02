import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';

import 'PointOfSales.dart';


class EmployeeMenu extends StatefulWidget {
  const EmployeeMenu({Key? key}) : super(key: key);
  @override
  State<EmployeeMenu> createState() => MenuPageState();
}

class MenuPageState extends State<EmployeeMenu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourPalette.backgroundColor,
      body: Material(
        color: ColourPalette.backgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
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
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(450, 65),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Point Of Sales',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Increased font weight for emphasis
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
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

                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(450, 65),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Create a Quiz',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Increased font weight for emphasis
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // New Button: View Quiz Stats
                const SizedBox(height: 40),
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

                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(450, 65),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'View Quiz Stats',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Increased font weight for emphasis
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // New Button: View Rankings
                const SizedBox(height: 40),
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

                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(450, 65),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text(
                          'View Rankings',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Increased font weight for emphasis
                            fontSize: 20,
                          ),
                        ),
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
