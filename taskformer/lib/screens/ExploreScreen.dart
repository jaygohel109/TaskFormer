import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ExploreCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // backgroundColor: Colors.black45,
          ),
        ),
      ),
    );
  }
}
