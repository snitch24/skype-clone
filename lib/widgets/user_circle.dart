import 'package:flutter/material.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/utils/utilities.dart';

class UserCircle extends StatefulWidget {
  const UserCircle({super.key, required this.text});
  final String text;

  @override
  State<UserCircle> createState() => _UserCircleState();
}

class _UserCircleState extends State<UserCircle> {
  String initials = "";
  @override
  void initState() {
    // TODO: implement initState
    String name = widget.text;
    setState(() {
      initials = Utils.getInitials(name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              initials,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: UniversalVariables.lightBlueColor,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: UniversalVariables.blackColor,
                    width: 2,
                  ),
                  color: UniversalVariables.onlineDotColor),
            ),
          )
        ],
      ),
    );
  }
}
