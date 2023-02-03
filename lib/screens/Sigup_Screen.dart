import 'package:authentication_using_firebase/controllers/auth_Controller.dart';
import 'package:authentication_using_firebase/screens/Admin_HomeScreen.dart';
import 'package:flutter/material.dart';

import 'Login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please Enter all the fields')));
      setState(() {
        _isLoading = false;
      });
    } else {
      String res = await AuthControllers().signUpUser(
          fullName: _fullNameController.text,
          email: _emailController.text,
          age: _ageController.text,
          password: _passwordController.text);
      setState(() {
        _isLoading = false;
      });
      if (res != 'Success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.toString())),
        );
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdminHomeScreen()));
      }
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
              'Sign Up Screen',
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
            controller: _fullNameController,
            decoration: InputDecoration(
              hintText: 'Full Name',
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
            ),
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(
              hintText: 'Enter Your Age',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: signupUser,
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              width: double.infinity,
              height: 50,
              child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Sign Up',
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
              Text('Already have an Account?'),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
                child: Text(
                  'Log In',
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
