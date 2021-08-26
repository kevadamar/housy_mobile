import 'package:flutter/material.dart';
import 'package:dev_mobile/utils/constants.dart';

class InputReuse extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final String label;
  final String type;
  final Widget icon;
  final bool isShowPassword;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool filled;

  const InputReuse({
    Key key,
    @required this.controller,
    @required this.color,
    @required this.label,
    this.icon,
    this.type = "text",
    this.isShowPassword = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.filled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isShowPassword,
      maxLines: type == 'multiline' ? 6 : 1,
      maxLength: type == 'multiline' ? 1000 : null,
      decoration: InputDecoration(
        filled: filled,
        labelText: '$label',
        labelStyle: TextStyle(
          color: color,
        ),
        hintText: 'Masukkan $label',
        hintStyle: TextStyle(
          color: color,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: identityColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: icon == null ? null : icon,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '$label is required';
        }

        // validation min character password
        if (value.length < 8 && type == 'password') {
          return "Min 8 character";
        }

        // validation format email
        if (!emailValidatorRegExp.hasMatch(value) && type == 'email') {
          return "Format Email is not valid";
        }

        // validation format phone number
        if (!phoneNumberValidatorRegExp.hasMatch(value) &&
            type == 'phoneNumber') {
          return "Phone Number is not valid";
        }
        return null;
      },
    );
  }
}
