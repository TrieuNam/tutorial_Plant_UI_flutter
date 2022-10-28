import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hinText;

  const CustomTextField({
    Key? key, required this.icon, required this.obscureText, required this.hinText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(
        color: Constants.blackColor,
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon,color: Constants.blackColor.withOpacity(.3),),
          hintText: hinText
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
}