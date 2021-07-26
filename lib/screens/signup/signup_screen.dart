import 'package:flutter/material.dart';
import 'package:housy_mobile/components/input_reuse/input_reuse_component.dart';
import 'package:housy_mobile/utils/constants.dart';
import 'package:housy_mobile/utils/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController listAs = TextEditingController();
  TextEditingController gender = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   title: Text(
      //     'Sign Up',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   foregroundColor: Colors.black,
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40, top: 30),
          alignment: Alignment.center,
          child: ListView(
              padding: EdgeInsets.only(
                bottom: 30,
              ),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: identityColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _formSignup(),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  _formSignup() {
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
                  ;
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
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                Icons.arrow_downward,
                color: Colors.deepPurple,
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: SizedBox(),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueListAs = newValue!;
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

          // Dropdown input List As
          Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                Icons.arrow_downward,
                color: Colors.deepPurple,
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: SizedBox(),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueGender = newValue!;
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
              _formKey.currentState?.validate();
              print(fullname.text);
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
