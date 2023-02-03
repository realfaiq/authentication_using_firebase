import 'package:flutter/material.dart';

import '../controllers/auth_Controller.dart';
import 'Login_Screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool isloading = false;

  void signOut(BuildContext context) async {
    setState(() {
      isloading = true;
    });
    await AuthControllers().signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LogInScreen()));
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Admin Home Screen'),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              signOut(context);
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                  child: isloading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.white),
                        )),
            ),
          )
        ]),
      )),
    );
  }
}
