import 'package:dev_mobile/components/input_reuse/input_reuse_component.dart';
import 'package:flutter/material.dart';
import 'package:dev_mobile/utils/constants.dart';
import 'package:dev_mobile/utils/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  bool _secureText = true;
  bool isDisabled = false;

  bool _emailError = false;
  bool _passwordError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: identityColor,
            shadowColor: Colors.red,
            elevation: 0,
            expandedHeight: 220.h,
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Signin',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
              collapseMode: CollapseMode.pin,
              background: SvgPicture.asset(
                'assets/images/brand.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: identityColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 35.h),
                margin: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    _formSignin(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _safeArea() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.h),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/brand.svg',
                    width: 250,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _formSignin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form _formSignin() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),

          // email
          InputReuse(
            controller: email,
            color: identityColor,
            label: "Email",
            type: "email",
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
          // TextFormField(
          //   controller: email,
          //   keyboardType: TextInputType.emailAddress,
          //   decoration: InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: identityColor,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: identityColor,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     labelText: "Email",
          //     labelStyle: TextStyle(
          //       color: identityColor,
          //     ),
          //     hintText: "Enter Your Email",
          //     hintStyle: TextStyle(
          //       color: identityColor,
          //     ),
          //     focusedErrorBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: Colors.red,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: Colors.red,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     suffixIcon: Padding(
          //       padding: const EdgeInsetsDirectional.only(
          //         end: 12.0,
          //       ),
          //       child: Icon(
          //         Icons.mail_outlined,
          //         color: identityColor,
          //       ),
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return "Email is required";
          //     }
          //     if (!emailValidatorRegExp.hasMatch(value)) {
          //       return "Format Email is not valid";
          //     }
          //   },
          // ),
          SizedBox(height: 40.h),

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
          // TextFormField(
          //   controller: password,
          //   keyboardType: TextInputType.visiblePassword,
          //   obscureText: _secureText,
          //   decoration: InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: identityColor,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: identityColor,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     focusedErrorBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: identityColor,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     errorBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: Colors.red,
          //       ),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     labelText: "Password",
          //     labelStyle: TextStyle(
          //       color: identityColor,
          //     ),
          //     hintText: "Enter Your Password",
          //     hintStyle: TextStyle(
          //       color: identityColor,
          //     ),
          //     suffixIcon: Padding(
          //       padding: const EdgeInsetsDirectional.only(
          //         end: 5,
          //       ),
          //       child: IconButton(
          //         onPressed: () {
          //           setState(() {
          //             _secureText = !_secureText;
          //           });
          //           ;
          //         },
          //         icon: Icon(
          //           _secureText
          //               ? Icons.lock_outlined
          //               : Icons.lock_open_outlined,
          //           color: identityColor,
          //         ),
          //       ),
          //     ),
          //   ),
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return "Password is required";
          //     }
          //     if (value.length <= 8) {
          //       return "Min 8 character";
          //     }
          //   },
          // ),
          SizedBox(height: 20.h),

          // forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () =>
                    null, //Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
          MaterialButton(
            minWidth: 400.w,
            onPressed: () {
              if (_emailError || _passwordError) {
                print('err email or password');
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
          SizedBox(height: 20.h),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(
                      fontSize: 15.sp,
                    )),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouterGenerator.signupScreen,
                  ),
                  child: Text(
                    "Here",
                    style: TextStyle(
                      fontSize: 15.sp,
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
