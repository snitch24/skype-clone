import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/utils/constants.dart';

class NewChatScreenButton extends StatelessWidget {
  const NewChatScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: UniversalVariables.fabGradient,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        FontAwesomeIcons.penToSquare,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
