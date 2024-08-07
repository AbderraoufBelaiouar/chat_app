import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Views/chat_view.dart';
import 'package:scholar_chat/Views/login_view.dart';
import 'package:scholar_chat/Views/register_view.dart';
import 'package:scholar_chat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginView.id,
      routes: {
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        ChatView.id: (context) => ChatView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
