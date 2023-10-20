import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => EmployeeDetailsState();
}

class EmployeeDetailsState extends State<EmployeeDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController fieldNameController = TextEditingController();
  TextEditingController newValueController = TextEditingController();

// Function to update an employee's information in Firestore and show a message
  void updateEmployee() async {
    try {
      String fieldToChange = fieldNameController.text;
      String newValue = newValueController.text;

      if (fieldToChange.isNotEmpty && newValue.isNotEmpty) {
        // Use the field name and new value to update the specific employee
        await _firestore.collection('EMPLOYEE').get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.update({
              fieldToChange: newValue,
            });
          });
        });

        // Clear the text fields
        fieldNameController.clear();
        newValueController.clear();

        // Show a SnackBar to inform the user that the update is completed
        final snackBar = SnackBar(
          content: Text('Employee updated successfully'),
          duration: Duration(seconds: 2), // You can adjust the duration as needed
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Show an error or inform the user that both fields are required.
        final snackBar = SnackBar(
          content: Text('Both fields are required'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print('Error updating employee: $e');
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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80),
                  Text(
                    "Employee Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      color: ColourPalette.textColor,
                    ),
                  ),
                  SizedBox(width: 160),
                  const SizedBox(height: 50),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('EMPLOYEE').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      final employees = snapshot.data!.docs;

                      return DataTable(
                        columns: [
                          DataColumn(
                            label: Text('Date Joined', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Employee ID', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Last Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Password', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Address', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          DataColumn(
                            label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                        ],
                        rows: employees.map((employee) {
                          final employeeData = employee.data() as Map<String, dynamic>;

                          return DataRow(
                            cells: [
                              DataCell(Text(
                                employeeData['Date_joined'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_ID'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_FName'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_LName'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_Password'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_address'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_email'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_phoneNo'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                employeeData['Emp_role'] ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ],
                          );
                        }).toList(),
                      );
                    },
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
                        updateEmployee();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(450, 65),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Update Employee',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
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
