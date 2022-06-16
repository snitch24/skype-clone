import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:skype_clone/firebase/firebase_repository.dart';
import 'package:skype_clone/screens/chatscreen/chat_screen.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/widgets/custom_tile.dart';

import '../models/app_user.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  List<AppUser> userList = [];
  String query = "";
  String _currentUserId = "";
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    _repository.getCurrentUser().then((user) {
      _currentUserId = user!.uid;
      _repository.fetchAllUsers(user).then((List<AppUser> list) {
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                UniversalVariables.gradientColorStart,
                UniversalVariables.gradientColorEnd
              ],
            ),
          ),
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
                  print(query);
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
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white.withOpacity(0.4)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        searchController.clear();
                        setState(() {
                          query = "";
                        });
                      });
                    },
                    icon: const Icon(
                      FontAwesomeIcons.x,
                      color: Colors.white,
                      size: 18,
                    ),
                    splashRadius: 20,
                  )),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Suggestions(
          query: query,
          userList: userList, currentUserId: _currentUserId,
        ),
      ),
    );
  }
}

class Suggestions extends StatelessWidget {
  const Suggestions({super.key, required this.query, required this.userList, required this.currentUserId});
  final String query;
  final List<AppUser> userList;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final List<AppUser> suggestionList = query.isEmpty
        ? []
        : userList.where((AppUser user) {
            String getUserName = user.userName!.toLowerCase();
            String getName = user.name!.toLowerCase();
            String lowerQuery = query.toLowerCase();
            bool matchUserName = getUserName.contains(lowerQuery);
            bool matchName = getName.contains(lowerQuery);
            return (matchName || matchUserName);
          }).toList();
    return suggestionList.isEmpty
        ? Center(
            child: UnDraw(
                illustration: UnDrawIllustration.no_data, color: Colors.blue),
          )
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: ((context, index) {
              AppUser searchedUser = AppUser(
                uid: suggestionList[index].uid,
                profilePhoto: suggestionList[index].profilePhoto,
                name: suggestionList[index].name,
                userName: suggestionList[index].userName,
              );
              return CustomTile(
                mini: false,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ChatScreen(
                            receiver: searchedUser,
                            currentUserId : currentUserId
                          )),
                    ),
                  );
                },
                onLongPress: () {},
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(searchedUser.profilePhoto!),
                  backgroundColor: Colors.grey,
                ),
                title: Text(
                  searchedUser.userName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  searchedUser.name!,
                  style: const TextStyle(
                    color: UniversalVariables.greyColor,
                  ),
                ),
              );
            }),
          );
  }
}
