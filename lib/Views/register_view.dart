import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Components/Custom_Text_Field.dart';
import 'package:scholar_chat/Components/Custom_button.dart';
import 'package:scholar_chat/Views/chat_view.dart';
import 'package:scholar_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = "registerView";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String password = "";
    String email = "";
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(KLogo),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Scholar Chat ",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  fieldName: "Email",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  obsecureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  fieldName: "password",
                ),
                Custom_button(
                  text: "Register",
                  onTapFunction: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser(email, password);
                        Navigator.pushNamed(context, ChatView.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, "The password provided is too weak");
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              "The account already exists for that email.");
                        }
                      }
                      isLoading = false;
                      setState(() {});
                      //
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 130, 202, 239)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
}

Future<void> registerUser(String email, String password) async {
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
}
