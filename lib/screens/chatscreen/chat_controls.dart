import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype_clone/utils/constants.dart';

class ChatControls extends StatefulWidget {
  const ChatControls({super.key});

  @override
  State<ChatControls> createState() => _ChatControlsState();
}

class _ChatControlsState extends State<ChatControls> {
  TextEditingController chatBoxController = TextEditingController();
  bool isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
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
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
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
                suffixIcon: GestureDetector(
                  child: const Icon(
                    FontAwesomeIcons.faceSmile,
                    color: Colors.white,
                  ),
                ),
                hintText: "Type a message",
                hintStyle: const TextStyle(
                  color: UniversalVariables.greyColor,
                ),
              ),
            ),
          ),
          isWriting
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      gradient: UniversalVariables.fabGradient,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        size: 18,
                      ),
                    ),
                  ),
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
