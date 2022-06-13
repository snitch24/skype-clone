import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/firebase/firebase_repository.dart';
import 'package:skype_clone/screens/bottom_navigation_screen.dart';
import 'package:skype_clone/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _repository.getCurrentUser(),
            builder: (context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData) {
                return BottomNavigationScreen();
              } else {
                return LoginScreen();
              }
            }));
  }
}
