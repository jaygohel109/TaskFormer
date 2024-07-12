import 'package:flutter/material.dart';
import 'package:taskformer/screens/home_screen.dart'; // Ensure HomePage is imported
import 'package:taskformer/screens/explore_screen.dart'; // Ensure ExploreScreen is imported
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/screens/openai_service.dart';
import 'package:taskformer/screens/chat_screen.dart';

class ChatSelectionScreen extends StatefulWidget {
  const ChatSelectionScreen({Key? key}) : super(key: key);

  @override
  _ChatSelectionScreenState createState() => _ChatSelectionScreenState();
}

class _ChatSelectionScreenState extends State<ChatSelectionScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> persons = [
      {
        'name': 'Napoleon Bonaparte',
        'image': 'assets/images/Emperor-Napoleon.png'
      },
      {'name': 'Marie Curie', 'image': 'assets/images/marie_curie.jpg'},
      {'name': 'Thomas Edison', 'image': 'assets/images/Thomas_Edison.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Historical Chat'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Who do you want to talk to?',
              style: TextStyle(color: Colors.yellow, fontSize: 18),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  final scale = _currentPage == index ? 1.0 : 0.8;
                  return _buildChatCard(
                    context,
                    persons[index]['name']!,
                    persons[index]['image']!,
                    scale,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final selectedPerson = persons[_currentPage];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      personName: selectedPerson['name']!,
                      personImage: selectedPerson['image']!,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              child: const Text('Select'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Set the current index to match the 'Chat' tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ExploreScreen()),
              );
              break;
            case 2:
              // Stay on the current screen
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildChatCard(
      BuildContext context, String name, String imageUrl, double scale) {
    return Transform.scale(
      scale: scale,
      child: Column(
        children: [
          Image.asset(imageUrl, height: 200),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
