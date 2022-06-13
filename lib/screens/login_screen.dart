import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/screens/bottom_navigation_screen.dart';

import '../firebase/firebase_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseRepository _repository = FirebaseRepository();
  bool isLoginPressed = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 500,
          width: 500,
          child: UnDraw(
            illustration: UnDrawIllustration.login,
            color: Colors.blue,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => performLogin(),
          icon: const Icon(FontAwesomeIcons.google),
          label: const Text("Login"),
        ),
      ],
    );
  }

  void performLogin() async {
    await _repository.signIn().then((User? user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        debugPrint("there was an error");
      }
    });
  }

  void authenticateUser(User user) async {
    _repository.authenticateUser(user).then(
      (isNewUser) {
        if (isNewUser) {
          _repository.addDataToDb(user).then(
            (value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const BottomNavigationScreen();
                  },
                ),
              );
            },
          );
        } else {
          return const BottomNavigationScreen();
        }
      },
    );
  }
}
