import 'package:flutter/material.dart';
import 'package:skype_clone/utils/constants.dart';

class SenderMessageBubble extends StatelessWidget {
  const SenderMessageBubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: const BoxDecoration(
            color: UniversalVariables.senderColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Hello",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
