import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/firebase/firebase_repository.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/widgets/appbar.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../models/app_user.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  late List<AppUser> userList;
  String query = "";
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    _repository.getCurrentUser().then((user) {
      _repository.fetchAllUsers(user!).then((List<AppUser> list) {
        setState(() {
          userList = list;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: GradientAppBar(
        gradient: const LinearGradient(
          colors: [
            UniversalVariables.gradientColorStart,
            UniversalVariables.gradientColorEnd
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 20,
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 20),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              cursorColor: UniversalVariables.blackColor,
              autofocus: true,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.cross,
                      color: Colors.white,
                    ),
                    splashRadius: 20,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
