import 'package:dev_mobile/components/input_reuse/input_reuse_component.dart';
import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:flutter/material.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final services = Services();

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  bool _secureText = true;

  bool isLoading = false;

  Future<void> handleSignin() async {
    try {
      setState(() {
        isLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final response = await services.signin(email.text, password.text);

      final status = response['status'];
      final msg =
          status != 200 ? 'Username or Password wrong!' : response['message'];

      print('$status');

      final snackBar = SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        duration: Duration(
          milliseconds: 2500,
        ),
        backgroundColor: status == 200 ? Colors.green[400] : Colors.red[700],
        width: 300, // Width of the SnackBar.
        padding: EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
      if (status == 200) {
        final data = response['data'];
        final role = data['user']['role'];

        authProvider.setToken(data['token']);
        _setPrefs(token: data['token'], role: role);

        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushNamedAndRemoveUntil(
            role == 'tenant'
                ? RouterGenerator.homeScreen
                : RouterGenerator.homeAdminScreen,
            (route) => false,
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } catch (e) {
      print('error : $e');
    }
  }

  Future<void> _setPrefs({String token, String role}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
    prefs.setString('role', role);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar(brightness: Brightness.light);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: identityColor,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: identityColor,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontSize: setFontSize(40),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  _formSignin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form _formSignin() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),

          // email
          InputReuse(
            controller: email,
            color: identityColor,
            label: "Email",
            type: 'email',
            keyboardType: TextInputType.emailAddress,
            icon: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: 12.0,
              ),
              child: Icon(
                Icons.mail_outlined,
                color: identityColor,
              ),
            ),
          ),
          SizedBox(height: 40),

          // password
          InputReuse(
            controller: password,
            color: identityColor,
            keyboardType: TextInputType.visiblePassword,
            isShowPassword: _secureText,
            type: "password",
            label: "Password",
            icon: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: 5,
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
                icon: Icon(
                  _secureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: identityColor,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // forgot password
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       onTap: () =>
          //           null, //Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
          //       child: Text(
          //         "Forgot Password",
          //         style: TextStyle(decoration: TextDecoration.underline),
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(height: 20),
          MaterialButton(
            minWidth: 400,
            onPressed: () {
              final isValid = _formKey.currentState.validate();
              FocusScope.of(context).unfocus();
              if (isValid) {
                handleSignin();
              }
            },
            color: identityColor,
            elevation: 5,
            focusColor: Colors.purple[700],
            child: Text(
              "SIGNIN",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouterGenerator.signupScreen,
                  ),
                  child: Text(
                    "Here",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
