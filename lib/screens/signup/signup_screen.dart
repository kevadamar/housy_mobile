import 'package:flutter/material.dart';
import 'package:housy_mobile/utils/routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
              context, RouterGenerator.signinScreen),
          child: Text('sign up'),
        ),
      ),
    );
  }
}
