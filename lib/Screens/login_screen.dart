import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../Widgets/rounded_button.dart';
import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  color: Colors.lightBlue,
                  title: 'Log In',
                  onPress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email!, password: password!);
                      if (credential != null) {
                        gotoChatScreen();
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        debugPrint('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        debugPrint('Wrong password provided for that user.');
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  gotoChatScreen() {
    Navigator.pushNamed(context, ChatScreen.id);
  }
}
