import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Components/Custom_Text_Field.dart';
import 'package:scholar_chat/Components/Custom_button.dart';
import 'package:scholar_chat/Views/chat_view.dart';
import 'package:scholar_chat/Views/register_view.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});
  static String id = "LoginView";
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey();
  String email = "";

  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                      Image.asset(
                        KLogo,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Scholar Chat ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Text(
                      "Login",
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
                  text: "Login",
                  onTapFunction: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await loginUser();

                        Navigator.pushNamed(context, ChatView.id,
                            arguments: email);
                        // Navigator.of(context).pushNamed('');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong password provided');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there is an error');
                      }
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterView.id,
                            arguments: email);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Color.fromARGB(255, 130, 202, 239)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password!);
  }
}
