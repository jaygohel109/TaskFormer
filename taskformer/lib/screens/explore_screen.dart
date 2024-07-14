import 'package:flutter/material.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/screens/home_screen.dart';
import 'package:taskformer/screens/chat_selection_screen.dart';
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/widgets/explore_card.dart';

class ExploreScreen extends StatefulWidget {
  final String? section;

  const ExploreScreen({Key? key, this.section}) : super(key: key);

  @override
  ExploreScreenState createState() => ExploreScreenState();
}

class ExploreScreenState extends State<ExploreScreen> {
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatSelectionScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
              if (widget.section == null || widget.section == 'Trending') ...[
                sectionTitle('Trending'),
                horizontalListView([
                  exploreCard('Moon Landing: One Giant Leap for Mankind', 'assets/images/moon_landing.jpg', 'The historic moon landing of 1969 marked humanity\'s first steps on another celestial body, symbolizing immense technological and exploratory achievement.'),
                  exploreCard('Napoleon in Europe', 'assets/images/napoleon.jpeg', 'Napoleon Bonaparte\'s reign in Europe was characterized by extensive military campaigns, significant political changes, and the establishment of the Napoleonic Code.'),
                ]),
                const SizedBox(height: 20),
              ],
              if (widget.section == null || widget.section == 'Time Periods') ...[
                sectionTitle('Time Periods'),
                horizontalListView([
                  exploreCard('Medieval Ages', 'assets/images/medieval.jpg', 'The Medieval Ages, also known as the Middle Ages, span from the 5th to the late 15th century, marked by feudalism, the rise of kingdoms, and the spread of Christianity.'),
                  exploreCard('Renaissance and Reformation', 'assets/images/renaissance.jpg', 'The Renaissance was a period of renewed interest in art, culture, and science, while the Reformation brought about significant religious transformation across Europe.'),
                  exploreCard('Ancient History', 'assets/images/ancient.jpeg', 'Ancient History encompasses the early civilizations of Mesopotamia, Egypt, Greece, and Rome, each contributing foundational advancements to human society.'),
                ]),
                const SizedBox(height: 20),
              ],
              if (widget.section == null || widget.section == 'Geographical Regions') ...[
                sectionTitle('Geographical Regions'),
                horizontalListView([
                  exploreCard('Asian History', 'assets/images/asian_history.jpg', 'Asian History spans vast and diverse cultures, including the ancient civilizations of China, India, and Japan, known for their rich contributions to world heritage.'),
                  exploreCard('African History', 'assets/images/african_history.jpg', 'African History is a tapestry of powerful kingdoms, colonial struggles, and rich cultural traditions that have significantly shaped the continent and the world.'),
                ]),
                const SizedBox(height: 20),
              ],
              if (widget.section == null || widget.section == 'Event and Movements') ...[
                sectionTitle('Event and Movements'),
                horizontalListView([
                  exploreCard('Wars and Conflicts', 'assets/images/wars.jpg', 'Wars and Conflicts have shaped history, from the ancient battles to the world wars, each leaving lasting impacts on nations and peoples.'),
                  exploreCard('Civil Rights Movements', 'assets/images/civil_rights.png', 'Civil Rights Movements across the globe have fought against oppression and discrimination, striving for equality and justice for all.'),
                  exploreCard('Revolutions', 'assets/images/revolutions.jpg', 'Revolutions, such as the American and French revolutions, have dramatically altered the political landscapes, championing ideas of freedom and democracy.'),
                ]),
                const SizedBox(height: 20),
              ],
              if (widget.section == null || widget.section == 'Exploration and Discovery') ...[
                sectionTitle('Exploration and Discovery'),
                horizontalListView([
                  exploreCard('Voyages of Exploration', 'assets/images/voyages.jpg', 'Voyages of Exploration during the Age of Discovery opened new trade routes, connected continents, and led to the exchange of goods, ideas, and cultures.'),
                  exploreCard('Space Exploration', 'assets/images/space_exploration.jpg', 'Space Exploration represents humanity\'s quest to explore beyond our planet, achieving milestones like the moon landing and the Mars rover missions.'),
                ]),
              ],
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

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget horizontalListView(List<Widget> children) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    );
  }

  Widget exploreCard(String title, String imageUrl, String description) {
    return ExploreCard2(
      title: title,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
