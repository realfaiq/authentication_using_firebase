import 'package:authentication_using_firebase/controllers/auth_Controller.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  void forgetPassword() async {
    setState(() {
      isLoading = true;
    });
    String res =
        await AuthControllers().resetPassword(email: _emailController.text);
    setState(() {
      isLoading = false;
    });
    if (res != 'Success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res.toString())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email Sent'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Enter Your Email',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: forgetPassword,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Send Recovery Link',
                        style: TextStyle(color: Colors.white),
                      )),
          ),
        )
      ]),
    ));
  }
}
