import 'package:flutter/material.dart';
import 'package:taskformer/screens/ChatScreen.dart';
import 'package:taskformer/screens/ExploreScreen.dart';
import 'package:taskformer/screens/TrandingScreen.dart';
import 'package:taskformer/screens/chat_selection_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current index for BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PASTPORT'),
          centerTitle: false,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            imageUrl:
                                'assets/images/geographical-event-image.png'),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChatCard(
                            name: "Leonardo da Vinci",
                            imageUrl: 'assets/images/leonardo.jpeg'),
                        ChatCard(
                            name: "Cleopatra VII",
                            imageUrl: 'assets/images/cleopatra-19.jpg'),
                        ChatCard(
                            name: "Napoleon Bonaparte",
                            imageUrl: 'assets/images/napolean.jpeg'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: const Center(child: Text('Explore Page Content jay')),
            ),
            Container(
              child: const Center(child: Text('Historical Chat Page Content')),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _currentIndex,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatSelectionScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}
