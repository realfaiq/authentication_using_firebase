import 'package:authentication_using_firebase/screens/Admin_HomeScreen.dart';
import 'package:authentication_using_firebase/screens/Doctor_HomeScreen.dart';
import 'package:authentication_using_firebase/screens/Patient_HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommonScreen extends StatefulWidget {
  const CommonScreen({super.key});

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  var userData = {};
  String userType = '';

  Future<String> check() async {
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    try {
      var snapData = await FirebaseFirestore.instance
          .collection('roles')
          .doc(currentUser)
          .get();
      userData = snapData.data()!;
      setState(() {
        userType = userData['role'];
      });
      return userData['role'];
    } catch (err) {
      print(err.toString());
    }
    return 'nothing';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: check(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return userType == 'Admin'
              ? AdminHomeScreen()
              : userType == 'Patient'
                  ? PatientHomeScreen()
                  : DoctorHomeScreen();
        } else {
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
          );
        }
      },
    );
  }
}
