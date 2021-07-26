import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneNumberValidatorRegExp =
    RegExp(r"^(^\+62|62|^08)(\d{3,4}-?){2}\d{3,4}$");

Color identityColor = Color.fromRGBO(90, 87, 171, 1);
