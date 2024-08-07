// ignore: must_be_immutable, camel_case_types
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Custom_button extends StatelessWidget {
  Custom_button({super.key, required this.onTapFunction, required this.text});
  Function()? onTapFunction;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: GestureDetector(
        onTap: onTapFunction,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6)),
          height: 40,
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
