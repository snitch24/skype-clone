import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/screens/chatscreen/chat_controls.dart';
import 'package:skype_clone/screens/chatscreen/reciever_message_bubble.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/widgets/appbar.dart';

import '../../models/app_user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiver});
  final AppUser receiver;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: CustomAppBar(
        context,
        title: Text(receiver.name!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.video),
            splashRadius: 20,
            iconSize: 18,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.phone),
            iconSize: 18,
            splashRadius: 20,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          splashRadius: 20,
          iconSize: 18,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: const [
          Flexible(
            child: MessageList(),
          ),
          ChatControls(),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      reverse: true,
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: const RecieverMessageBubble(),
        );
      }),
    );
  }
}
