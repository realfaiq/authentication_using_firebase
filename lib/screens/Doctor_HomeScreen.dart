import 'package:authentication_using_firebase/controllers/auth_Controller.dart';
import 'package:authentication_using_firebase/screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
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
          Text('Doctor Home Screen'),
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
