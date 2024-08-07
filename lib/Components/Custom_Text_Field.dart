import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key, this.onChanged, this.fieldName, this.obsecureText});
  Function(String)? onChanged;
  String? fieldName;
  bool? obsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText != null ? obsecureText! : false,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 74, 136, 190)),
        ),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        hintText: fieldName,
      ),
    );
  }
}
