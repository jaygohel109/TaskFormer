import 'package:flutter/material.dart';
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/screens/home_screen.dart'; // Ensure HomePage is imported
import 'package:taskformer/screens/chat_selection_screen.dart'; // Ensure ChatSelectionScreen is imported
import 'package:taskformer/widgets/explore_card.dart'; // Ensure ExploreCard2 is imported

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  ExploreScreenState createState() => ExploreScreenState();
}

class ExploreScreenState extends State<ExploreScreen> {
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
              builder: (context) =>
                  const HomePage()), // Ensure HomePage is defined as const
        );
        break;
      case 1:
        // Stay on the current screen
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const ChatSelectionScreen()), // Ensure ChatSelectionScreen is defined as const
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const ProfileScreen()), // Ensure ProfileScreen is defined as const
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trending',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ExploreCard2(
                      title: 'Moon Landing: One Giant Leap for Mankind',
                      imageUrl: 'assets/images/moon_landing.jpg',
                      description:
                          'The historic moon landing of 1969 marked humanity\'s first steps on another celestial body, symbolizing immense technological and exploratory achievement.',
                    ),
                    ExploreCard2(
                      title: 'Napoleon in Europe',
                      imageUrl: 'assets/images/napoleon.jpeg',
                      description:
                          'Napoleon Bonaparte\'s reign in Europe was characterized by extensive military campaigns, significant political changes, and the establishment of the Napoleonic Code.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Time Periods',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ExploreCard2(
                      title: 'Medieval Ages',
                      imageUrl: 'assets/images/medieval.jpg',
                      description:
                          'The Medieval Ages, also known as the Middle Ages, span from the 5th to the late 15th century, marked by feudalism, the rise of kingdoms, and the spread of Christianity.',
                    ),
                    ExploreCard2(
                      title: 'Renaissance and Reformation',
                      imageUrl: 'assets/images/renaissance.jpg',
                      description:
                          'The Renaissance was a period of renewed interest in art, culture, and science, while the Reformation brought about significant religious transformation across Europe.',
                    ),
                    ExploreCard2(
                      title: 'Ancient History',
                      imageUrl: 'assets/images/ancient.jpeg',
                      description:
                          'Ancient History encompasses the early civilizations of Mesopotamia, Egypt, Greece, and Rome, each contributing foundational advancements to human society.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Geographical Regions',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ExploreCard2(
                      title: 'Asian History',
                      imageUrl: 'assets/images/asian_history.jpg',
                      description:
                          'Asian History spans vast and diverse cultures, including the ancient civilizations of China, India, and Japan, known for their rich contributions to world heritage.',
                    ),
                    ExploreCard2(
                      title: 'African History',
                      imageUrl: 'assets/images/african_history.jpg',
                      description:
                          'African History is a tapestry of powerful kingdoms, colonial struggles, and rich cultural traditions that have significantly shaped the continent and the world.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Event and Movements',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ExploreCard2(
                      title: 'Wars and Conflicts',
                      imageUrl: 'assets/images/wars.jpg',
                      description:
                          'Wars and Conflicts have shaped history, from the ancient battles to the world wars, each leaving lasting impacts on nations and peoples.',
                    ),
                    ExploreCard2(
                      title: 'Civil Rights Movements',
                      imageUrl: 'assets/images/civil_rights.png',
                      description:
                          'Civil Rights Movements across the globe have fought against oppression and discrimination, striving for equality and justice for all.',
                    ),
                    ExploreCard2(
                      title: 'Revolutions',
                      imageUrl: 'assets/images/revolutions.jpg',
                      description:
                          'Revolutions, such as the American and French revolutions, have dramatically altered the political landscapes, championing ideas of freedom and democracy.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Exploration and Discovery',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ExploreCard2(
                      title: 'Voyages of Exploration',
                      imageUrl: 'assets/images/voyages.jpg',
                      description:
                          'Voyages of Exploration during the Age of Discovery opened new trade routes, connected continents, and led to the exchange of goods, ideas, and cultures.',
                    ),
                    ExploreCard2(
                      title: 'Space Exploration',
                      imageUrl: 'assets/images/space_exploration.jpg',
                      description:
                          'Space Exploration represents humanity\'s quest to explore beyond our planet, achieving milestones like the moon landing and the Mars rover missions.',
                    ),
                  ],
                ),
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
