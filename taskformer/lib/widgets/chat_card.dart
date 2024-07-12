import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ChatCard({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imageUrl),
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}