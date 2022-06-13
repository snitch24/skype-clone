import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/screens/pages/calls_page.dart';
import 'package:skype_clone/screens/pages/contacts_page.dart';
import 'package:skype_clone/screens/pages/message_page.dart';
import 'package:skype_clone/utils/constants.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;
  void onTap(int currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  final List<Widget> _pages = [
    const MessagePage(),
    const CallsPage(),
    const ContactsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTap,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: UniversalVariables.blackColor,
        selectedItemColor: UniversalVariables.lightBlueColor,
        unselectedItemColor: UniversalVariables.greyColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.phone),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.addressBook,
            ),
            label: "Contacts",
          )
        ],
      ),
    );
  }
}
