import 'package:authentication_using_firebase/controllers/auth_Controller.dart';
import 'package:authentication_using_firebase/screens/Admin_HomeScreen.dart';
import 'package:authentication_using_firebase/screens/Common_Screen.dart';
import 'package:authentication_using_firebase/screens/Doctor_HomeScreen.dart';
import 'package:authentication_using_firebase/screens/Patient_HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Sigup_Screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logIn() async {
    String res = await AuthControllers().logInUser(
        email: _emailController.text, password: _passwordController.text);

    if (res != 'Success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res.toString())));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CommonScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        children: [
          Align(
            alignment: Alignment.center,
            child: const Text(
              'Log In Screen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: logIn,
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              width: double.infinity,
              height: 40,
              child: Center(
                  child: Text(
                'Log In',
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an Account?'),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
