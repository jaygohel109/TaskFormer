import 'package:flutter/material.dart';
import 'package:taskformer/screens/HomeScreen.dart';
import 'package:taskformer/screens/explore_screen.dart';
import 'package:taskformer/screens/chat_selection_screen.dart';
import 'package:taskformer/screens/profile_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: widget.currentIndex,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index != widget.currentIndex) {
          widget.onTap(index);
          Widget nextScreen;
          switch (index) {
            case 0:
              nextScreen = const HomePage();
              break;
            case 1:
              nextScreen = const ExploreScreen();
              break;
            case 2:
              nextScreen = const ChatSelectionScreen();
              break;
            case 3:
              nextScreen = const ProfileScreen();
              break;
            default:
              nextScreen = const HomePage();
          }

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => nextScreen,
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
    );
  }
}
