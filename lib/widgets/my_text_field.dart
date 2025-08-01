import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, this.hintText, this.controller, this.obsecureText= false, this.keyboardType, this.validator, this.fillColor});

  final String? hintText;
  final TextEditingController? controller;
  final bool obsecureText;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final Color? fillColor;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor:fillColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          )
        )
      ),
    );
  }
}