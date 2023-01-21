import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Screens/chat_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import '../Widgets/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
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
                      hintText: 'Enter your Password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  color: Colors.blueAccent,
                  title: 'Register',
                  onPress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email!, password: password!);
                      if (credential != null) {
                        gotoChatScreen();
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        debugPrint('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        debugPrint(
                            'The account already exists for that email.');
                      }
                    } catch (e) {
                      debugPrint('e');
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
