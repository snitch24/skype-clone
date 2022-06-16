import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/firebase/firebase_repository.dart';
import 'package:skype_clone/models/app_user.dart';
import 'package:skype_clone/models/message.dart';
import 'package:skype_clone/screens/chatscreen/add_media_bottom_sheet.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/utils/utilities.dart';

class ChatControls extends StatefulWidget {
  final AppUser receiver;
  final String currentUserId;
  
  const ChatControls(
      {super.key,
      required this.receiver,
      required this.currentUserId,
  });

  @override
  State<ChatControls> createState() => _ChatControlsState();
}

class _ChatControlsState extends State<ChatControls> {
  TextEditingController chatBoxController = TextEditingController();
  bool isWriting = false;

  final FirebaseRepository _repository = FirebaseRepository();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showBottomSheet(
                  elevation: 0,
                  backgroundColor: UniversalVariables.blackColor,
                  context: context,
                  builder: (context) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    return const AddMediaBottomSheet();
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: UniversalVariables.fabGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.plus,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
              
              focusNode: focusNode,
              controller: chatBoxController,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {
                if (value.isNotEmpty && value.trim().isNotEmpty) {
                  setState(() {
                    isWriting = true;
                  });
                } else {
                  setState(() {
                    isWriting = false;
                  });
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: UniversalVariables.separatorColor,
                hintText: "Type a message",
                hintStyle: const TextStyle(
                  color: UniversalVariables.greyColor,
                ),
              ),
            ),
          ),
          isWriting
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: UniversalVariables.fabGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 250),
                        child: IconButton(
                          onPressed: () {
                            String text = chatBoxController.text;
                            Message message = Message(
                              message: text,
                              receiverId: widget.receiver.uid!,
                              senderId: widget.currentUserId,
                              type: "text",
                              timeStamp: Timestamp.now(),
                            );
                            setState(() {
                              isWriting = false;
                              chatBoxController.clear();
                            });
                            _repository.addMessageToDb(
                                message, widget.currentUserId, widget.receiver);
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(FontAwesomeIcons.microphone),
                    ),
                    Icon(FontAwesomeIcons.camera)
                  ],
                ),
        ],
      ),
    );
  }
}
