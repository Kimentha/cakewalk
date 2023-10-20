import 'package:cakewalkweb/OwnerMenu.dart';
import 'package:flutter/material.dart';
import 'package:cakewalkweb/ColorPalette.dart';
import 'package:cakewalkweb/EmployeeMenu.dart';


class LoginPage extends StatefulWidget {


  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  String username = "";
  String password = "";
  String emp= "";


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
                  child: SingleChildScrollView(
                      child: Form(
                          child: Container(
                            width: 500,
                            height: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white
                            ),

                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(

                                    ///PAGE NAME
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50,
                                            color: ColourPalette.textColor
                                        ),
                                      )),
                                  Container(
                                    ///Username TEXTFIELD
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 400,
                                      child: TextFormField(
                                        controller: usernameController,
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
                                          hintText: 'Enter Username',
                                            hintStyle: TextStyle(color: ColourPalette.textColor )

                                        ),
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted: (value) {},
                                        validator: (value) {
                                        },
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    ///PASSWORD TEXTFIELD
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: SizedBox(
                                      width: 400,
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
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
                                          hintText: 'Enter Password',
                                            hintStyle: TextStyle(color: ColourPalette.textColor ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted: (value) {},
                                        validator: (value) {

                                        },
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    ///FORGET PASSWORD TEXT BUTTON
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        onPressed: () {
                                          ///shows message
                                         // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ForgotPasswordPage()));
                                          _showdialog(context, 'Please contact store owner');
                                          //GO TO FORGOT PASSWORD PAGE
                                        },
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
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
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            username = usernameController.text;
                                            password = passwordController.text;

                                            // Check if the username is "admin" or "employee"
                                            if (username.toLowerCase() == "admin" || username.toLowerCase() == "employee") {
                                              // Check the corresponding password
                                              if ((username.toLowerCase() == "admin" && password == "A123") ||
                                                  (username.toLowerCase() == "employee" && password == "E123")) {
                                                // Password is correct, proceed to login
                                                if (username.toLowerCase() == "admin" && password == "A123"){
                                                  emp="A0032";
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>  OwnerMenu(emp: emp),
                                                  ),
                                                );}
                                                else{
                                                  emp="E0052";
                                                  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                  builder: (context) =>  EmployeeMenu(emp: emp),
                                                  ),
                                                  );
                                                  }

                                              } else {
                                                // Incorrect password
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text("Incorrect Password"),
                                                      content: Text("Please enter the correct password."),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("OK"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            } else {
                                              // Invalid username
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("Invalid Username"),
                                                    content: Text("Please enter a valid username (admin or employee)."),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("OK"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(395, 55), backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold, // Increased font weight for emphasis
                                              fontSize: 20, // A contrasting color to stand out
                                            ),
                                          ),

                                        ),
                                      ),

                                    ],
                                  )
                                ]),
                          )))))),
        );
  }


}
class NavItem extends StatelessWidget {
  const NavItem({
    required Key key,
    required this.title,
    required this.tapEvent
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
              fontSize: 18

          ),
        ),
      ),
    );
  }
}

void _showdialog(BuildContext context, String dialogContent) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Custom Dialog Title'),
        content: Text(dialogContent),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
