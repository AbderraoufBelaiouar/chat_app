import 'package:flutter/material.dart';
import 'package:scholar_chat/Components/Custom_chat_buble.dart';
import 'package:scholar_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/message.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({super.key});
  static String id = "ChatView";
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KmessagesCollecton);
  final _ScrollController = ScrollController();
  String message = "";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KcreatedAt).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    KLogo,
                    height: 50,
                  ),
                  const Text(
                    "chat",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _ScrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? chatBuble(
                              message: messagesList[index].message,
                            )
                          : chatBubleForFriend(
                              message: messagesList[index].message,
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          Kmessage: data,
                          KcreatedAt: DateTime.now(),
                          Kid: email
                        },
                      );
                      controller.clear();
                      _ScrollController.jumpTo(
                        _ScrollController.position.maxScrollExtent,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "send Message",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text("loading .......");
        }
      },
    );
  }
}
