import 'package:flutter/material.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/screens/home_screen.dart';
import 'package:taskformer/screens/chat_selection_screen.dart';
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/screens/explore_screen.dart';

class DetailedViewScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;

  const DetailedViewScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  DetailedViewScreenState createState() => DetailedViewScreenState();
}

class DetailedViewScreenState extends State<DetailedViewScreen> {
  int _currentIndex = 1; // Set the default index for Explore

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ExploreScreen(),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatSelectionScreen(),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.imageUrl),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
