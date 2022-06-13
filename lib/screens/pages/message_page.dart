import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/firebase/firebase_repository.dart';
import 'package:skype_clone/utils/constants.dart';
import 'package:skype_clone/utils/utilities.dart';
import 'package:skype_clone/widgets/user_circle.dart';

import '../../widgets/appbar.dart';
import '../../widgets/custom_tile.dart';
import '../../widgets/new_chat_screen_button.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

final FirebaseRepository _repository = FirebaseRepository();

class _MessagePageState extends State<MessagePage> {
  late String currentUserId;
  String initials = "";
  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) => setState(() {
          currentUserId = user!.uid;
          initials = Utils.getInitials(user.displayName!);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const NewChatScreenButton(),
      backgroundColor: UniversalVariables.blackColor,
      appBar: CustomAppBar(
        context,
        leading: IconButton(
          splashRadius: 20.0,
          icon: const Icon(FeatherIcons.bell),
          onPressed: () {},
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20.0,
            onPressed: () {
              Navigator.pushNamed(context, '/search_screen');
            },
            icon: const Icon(FeatherIcons.search),
          ),
          IconButton(
            splashRadius: 20.0,
            onPressed: () {},
            icon: const Icon(
              FeatherIcons.moreVertical,
            ),
          ),
        ],
        title: UserCircle(text: initials),
      ),
      body: const ChatListContainer(),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  const ChatListContainer({super.key});

  @override
  State<ChatListContainer> createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 2,
      itemBuilder: ((context, index) {
        return CustomTile(
          mini: false,
          onTap: () {},
          onLongPress: () {},
          title: const Text(
            "Snitch",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Arial",
              fontSize: 19,
            ),
          ),
          subtitle: const Text(
            "Hello",
            style: TextStyle(
              color: UniversalVariables.greyColor,
              fontSize: 14,
            ),
          ),
          leading: Container(
            constraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
            child: Stack(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: UniversalVariables.greyColor,
                  backgroundImage: NetworkImage(
                      "https://static.wikia.nocookie.net/harrypotter/images/8/82/Dobby.jpg/revision/latest?cb=20161215055153"),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: UniversalVariables.onlineDotColor,
                      border: Border.all(
                        color: UniversalVariables.blackColor,
                        width: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
