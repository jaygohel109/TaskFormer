import 'package:flutter/material.dart';
import 'package:taskformer/screens/home_screen.dart'; // Ensure HomePage is imported
import 'package:taskformer/screens/explore_screen.dart'; // Ensure ExploreScreen is imported
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
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
      {'name': 'Napoleon Bonaparte', 'image': 'assets/images/Emperor-Napoleon.png'},
      {'name': 'Marie Curie', 'image': 'assets/images/marie_curie.png'},
      {'name': 'Thomas Edison', 'image': 'assets/images/Thomas_Edison.png'},
      {'name': 'Mahatma Gandhi', 'image': 'assets/images/mahatma_gandhi.png'},
      {'name': 'Cleopatra', 'image': 'assets/images/cleopatra.png'},
      {'name': 'Abraham Lincoln', 'image': 'assets/images/abraham_lincoln.png'},
      {'name': 'Leonardo da Vinci', 'image': 'assets/images/leonardo_da_vinci.png'},
      {'name': 'Nelson Mandela', 'image': 'assets/images/nelson_mandela.png'},
      {'name': 'William Shakespeare', 'image': 'assets/images/william_shakespeare.png'},
      {'name': 'Martin Luther King Jr.', 'image': 'assets/images/martin_luther_king_jr.png'},
      {'name': 'Amelia Earhart', 'image': 'assets/images/amelia_earhart.png'},
      {'name': 'Isaac Newton', 'image': 'assets/images/isaac_newton.png'},
      {'name': 'Queen Victoria', 'image': 'assets/images/queen_victoria.png'},
      {'name': 'George Washington', 'image': 'assets/images/george_washington.png'},
      {'name': 'Alexander the Great', 'image': 'assets/images/alexander_the_great.png'},
      {'name': 'Florence Nightingale', 'image': 'assets/images/florence_nightingale.png'},
      {'name': 'Socrates', 'image': 'assets/images/socrates.png'},
      {'name': 'Susan B. Anthony', 'image': 'assets/images/susan_b_anthony.png'},
      {'name': 'Rosa Parks', 'image': 'assets/images/rosa_parks.png'},
      {'name': 'Harriet Tubman', 'image': 'assets/images/harriet_tubman.png'},
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
              height: 400,
              child: Stack(
                children: [
                  PageView.builder(
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
                  _buildSideImage(persons, _currentPage - 1, Alignment.centerLeft),
                  _buildSideImage(persons, _currentPage + 1, Alignment.centerRight),
                ],
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
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

  Widget _buildChatCard(BuildContext context, String name, String imageUrl, double scale) {
    return Transform.scale(
      scale: scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSideImage(List<Map<String, String>> persons, int index, Alignment alignment) {
    if (index < 0 || index >= persons.length) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: alignment,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: 0.6, // Reduced opacity for side images
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(persons[index]['image']!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
