import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

// ignore: must_be_immutable
class chatBuble extends StatelessWidget {
  chatBuble({super.key, required this.message});
  String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}

class chatBubleForFriend extends StatelessWidget {
  const chatBubleForFriend({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        decoration: const BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}
