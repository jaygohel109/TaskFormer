import 'package:flutter/material.dart';
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/screens/HomeScreen.dart'; // Ensure HomePage is imported
import 'package:taskformer/screens/chat_selection_screen.dart'; // Ensure ChatSelectionScreen is imported

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 1; // Set the default index for Explore

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()), // Ensure HomePage is defined as const
        );
        break;
      case 1:
        // Stay on the current screen
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatSelectionScreen()), // Ensure ChatSelectionScreen is defined as const
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()), // Ensure ChatSelectionScreen is defined as const
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Explore'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: const Text('Explore Page Content jay'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
