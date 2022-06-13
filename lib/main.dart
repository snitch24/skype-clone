import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skype_clone/screens/home_screen.dart';
import 'package:skype_clone/screens/search_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: "/home_screen",
      routes: {
        '/search_screen':(context) => const SearchScreen(),
        '/home_screen': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
