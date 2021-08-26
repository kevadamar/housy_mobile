import 'dart:io';

import 'package:dev_mobile/providers/auth_provider.dart';
import 'package:dev_mobile/services/services.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:dev_mobile/components/input_reuse/input_reuse_component.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Services services = Services();

  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // TextEditingController gender = TextEditingController();
  // TextEditingController listAs = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String dropdownValueListAs = 'Tenant';
  String dropdownValueGender = 'Male';

  bool _secureText = true;
  bool isDisabled = false;

  bool _emailError = false;
  bool _passwordError = false;

  bool isLoading = false;

  Future<void> handleSignup() async {
    try {
      setState(() {
        isLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final response = await services.signup(
          fullname.text,
          username.text,
          email.text,
          password.text,
          dropdownValueListAs,
          dropdownValueGender,
          phone.text,
          address.text);

      final status = response['status'];
      final msg = status != 200 ? response['message'] : response['message'];

      print('$status ${response['message']}');

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
    return Scaffold(
      body: Container(
        color: identityColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: identityColor,
              shadowColor: Colors.red,
              elevation: 0,
              expandedHeight: deviceHeight() * 0.28,
              pinned: true,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Platform.isAndroid
                    ? Icon(
                        Icons.arrow_back,
                      )
                    : Icon(
                        Icons.arrow_back_ios,
                      ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: setFontSize(30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    _formSignup(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Form _formSignup() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),

          // fullname
          InputReuse(
            controller: fullname,
            color: identityColor,
            label: "Fullname",
          ),
          SizedBox(height: 40),

          // username
          InputReuse(
            controller: username,
            color: identityColor,
            label: "Username",
          ),
          SizedBox(height: 40),

          //email
          InputReuse(
            controller: email,
            color: identityColor,
            label: "Email",
            type: "email",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 40),

          //password
          InputReuse(
            keyboardType: TextInputType.visiblePassword,
            isShowPassword: _secureText,
            type: "password",
            controller: password,
            color: identityColor,
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
          SizedBox(height: 40),

          // Dropdown input List As
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              // color: identityColor,
              border: Border.all(
                width: 1,
                color: identityColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: dropdownValueListAs,
              hint: Text(
                'List As',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: identityColor,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.deepPurple,
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: SizedBox(),
              isExpanded: true,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueListAs = newValue;
                });
              },
              items: <String>['Tenant', 'Owner']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 40),

          // Dropdown input Gender
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              // color: identityColor,
              border: Border.all(
                width: 1,
                color: identityColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              value: dropdownValueGender,
              hint: Text(
                'List As',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: identityColor,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.deepPurple,
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: SizedBox(),
              isExpanded: true,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueGender = newValue;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 40),

          //phone
          InputReuse(
            controller: phone,
            color: identityColor,
            label: "Phone Number",
            type: "phoneNumber",
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 40),

          // address
          InputReuse(
            controller: address,
            color: identityColor,
            label: "Address",
            type: "multiline",
          ),

          SizedBox(height: 40),

          MaterialButton(
            minWidth: 400,
            onPressed: () {
              if (_emailError || _passwordError) {
                print('err email or password');
              }
              final isValid = _formKey.currentState.validate();
              FocusScope.of(context).unfocus();
              if (isValid) {
                handleSignup();
              }
            },
            color: identityColor,
            elevation: 5,
            focusColor: Colors.purple[700],
            child: Text(
              "SIGNUP",
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
                Text("Have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
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
