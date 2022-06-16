import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:skype_clone/screens/chatscreen/chat_controls.dart';
import 'package:skype_clone/screens/chatscreen/reciever_message_bubble.dart';
import 'package:skype_clone/screens/chatscreen/sender_message_bubble.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/widgets/appbar.dart';

import '../../models/app_user.dart';
import '../../models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.receiver, required this.currentUserId});
  final AppUser receiver;
  final String currentUserId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showEmojiKeyboard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: CustomAppBar(
        context,
        title: Text(widget.receiver.name!),
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
        children: [
          Flexible(
            child: MessageList(
              receiver: widget.receiver,
              currentUserId: widget.currentUserId,
            ),
          ),
          ChatControls(
              receiver: widget.receiver,
              currentUserId: widget.currentUserId,
              emojiCallBack: (showEmoji) {
                setState(() {
                  showEmojiKeyboard = showEmoji;
                });
              }),
          showEmojiKeyboard
              ? const CustomEmojiPicker()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class CustomEmojiPicker extends StatelessWidget {
  const CustomEmojiPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          // Do something when emoji is tapped
        },
        onBackspacePressed: () {
          // Backspace-Button tapped logic
          // Remove this line to also remove the button in the UI
        },
        config: Config(
          columns: 7,
          emojiSizeMax: 32 *
              (Platform.isIOS
                  ? 1.30
                  : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: UniversalVariables.separatorColor,
          indicatorColor: UniversalVariables.blueColor,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          progressIndicatorColor: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  final AppUser receiver;
  final String currentUserId;
  const MessageList(
      {super.key, required this.receiver, required this.currentUserId});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("messages")
          .doc(widget.currentUserId)
          .collection(widget.receiver.uid!)
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return UnDraw(
              illustration: UnDrawIllustration.server_down,
              color: UniversalVariables.blueColor);
        } else if (snapshot.hasData) {
          // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          //   scrollController.animateTo(
          //     scrollController.position.minScrollExtent,
          //     duration: const Duration(milliseconds: 250),
          //     curve: Curves.easeOut,
          //   );
          // });
          return ListView.builder(
              controller: scrollController,
              reverse: true,
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, item) {
                Message message =
                    Message.fromMap(snapshot.data!.docs[item].data());
                if (message.senderId == widget.currentUserId) {
                  return SenderMessageBubble(
                    text: message.message,
                  );
                } else {
                  return RecieverMessageBubble(
                    text: message.message,
                  );
                }
              });
        } else {
          return UnDraw(
            illustration: UnDrawIllustration.empty,
            color: UniversalVariables.blueColor,
          );
        }
      },
    );
  }
}
