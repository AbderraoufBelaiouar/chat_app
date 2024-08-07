// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:scholar_chat/constants.dart';

class Message {
  final String message;
  final String id;
  Message({
    required this.message,
    required this.id,
  });
  factory Message.fromJson(jsonData) {
    return Message(message: jsonData[Kmessage], id: jsonData[Kid]);
  }
}
