import 'package:flutter/material.dart';
import 'package:skype_clone/screens/chatscreen/modal_tile.dart';

class AddMediaBottomSheet extends StatelessWidget {
  const AddMediaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: const Icon(Icons.close),
                label: const SizedBox.shrink(),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Contents and tools",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: ListView(
            children: const [
              ModalTile(
                title: "Media",
                subtitle: "Share Photos and Videos",
                icon: Icons.image,
              ),
              ModalTile(
                title: "File",
                subtitle: "Share files",
                icon: Icons.tab,
              ),
              ModalTile(
                title: "Contact",
                subtitle: "Share contacts",
                icon: Icons.contacts,
              ),
              ModalTile(
                title: "Location",
                subtitle: "Share a location",
                icon: Icons.add_location,
              ),
              ModalTile(
                title: "Schedule Call",
                subtitle: "Arrange a skype call and get reminders",
                icon: Icons.schedule,
              ),
              ModalTile(
                title: "Create Poll",
                subtitle: "Share polls",
                icon: Icons.poll,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
