import 'package:flash_chat/Screens/login_screen.dart';
import 'package:flash_chat/Screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../Widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 45.0,
                      color: Colors.black),
                  child: AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                        speed: const Duration(milliseconds: 70))
                  ]),
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlue,
                title: 'Log In',
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPress: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
