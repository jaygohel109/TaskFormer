import 'package:flutter/material.dart';
import 'package:taskformer/screens/explore_screen.dart'; // Ensure ExploreScreen is imported
import 'package:taskformer/screens/chat_selection_screen.dart'; // Ensure ChatSelectionScreen is imported
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/widgets/trending_card.dart';
import 'package:taskformer/widgets/explore_card.dart';
import 'package:taskformer/widgets/chat_card.dart';
import 'package:taskformer/screens/profile_screen.dart';
import 'package:taskformer/screens/chat_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        // Stay on the current screen
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ExploreScreen()),
        );
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
    final List<Map<String, String>> persons = [
      {'name': 'Leonardo da Vinci ', 'image': 'assets/images/leonardo.jpeg'},
      {'name': ' Cleopatra VII ', 'image': 'assets/images/cleopatra-19.jpg'},
      {'name': ' Napoleon Bonaparte', 'image': 'assets/images/napolean.jpeg'},
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo_yellow.png', // Make sure to update the path as per your asset location
                height: 60, // Adjust the height as needed
              ),
            ],
          ),
          centerTitle: false,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Trending'),
              Tab(text: 'Explore'),
              Tab(text: 'Historical Chat'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.yellow,
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Trending',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: PageView(
                        children: const [
                          TrendingCard(
                            title: "Edison's Lightbulb Revolution",
                            subtitle: "Discovery",
                            imageUrl: 'assets/images/edison-light-bulb.jpg',
                          ),
                          TrendingCard(
                            title: "Leonardo's Masterpiece",
                            subtitle: "Culture",
                            imageUrl: 'assets/images/leonardo.jpeg',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Explore',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: const [
                        ExploreCard(
                            title: "Time Periods",
                            imageUrl: 'assets/images/time-period.jpeg'),
                        ExploreCard(
                            title: "Geographical Regions",
                            imageUrl: 'assets/images/geographical-event-image.png'),
                        ExploreCard(
                            title: "Events",
                            imageUrl: 'assets/images/image copy.png'),
                        ExploreCard(
                            title: "Discovery",
                            imageUrl: 'assets/images/image.png'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Historical Chat',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...persons.map((person) {
                            return ChatCard(
                              name: person['name']!,
                              imageUrl: person['image']!,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      personName: person['name']!,
                                      personImage: person['image']!,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward, color: Colors.yellow),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChatSelectionScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: const Center(child: Text('Explore Page Content')),
            ),
            Container(
              child: const Center(child: Text('Historical Chat Page Content')),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
