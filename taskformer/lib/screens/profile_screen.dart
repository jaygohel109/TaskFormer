import 'package:flutter/material.dart';
import 'package:taskformer/widgets/custom_bottom_navigation_bar.dart';
import 'package:taskformer/screens/HomeScreen.dart';
import 'package:taskformer/screens/explore_screen.dart';
import 'package:taskformer/screens/chat_selection_screen.dart';
import 'package:taskformer/screens/login_screen.dart';
import 'package:taskformer/Database/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Set the current index to match the 'Profile' tab
  String _username = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final username = await DatabaseHelper().getCurrentUsername();
    setState(() {
      _username = username ?? "Unknown";
    });
  }

  Future<void> _logout() async {
    await DatabaseHelper().logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => LoginScreen()), // Remove const here
      (Route<dynamic> route) => false, // This line clears the back stack
    );
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()), // Remove const here
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ExploreScreen()), // Remove const here
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatSelectionScreen()), // Remove const here
          );
          break;
        case 3:
          // Stay on the current screen
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0), // Adjust this value to control the space
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _username,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ProfileMenuItem(
                icon: Icons.person, text: 'Edit Profile', onTap: () {}),
            ProfileMenuItem(icon: Icons.book, text: 'Notebook', onTap: () {}),
            ProfileMenuItem(
              icon: Icons.notifications,
              text: 'Notifications',
              onTap: () {},
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.yellow,
              ),
            ),
            ProfileMenuItem(
                icon: Icons.language, text: 'Languages', onTap: () {}),
            ProfileMenuItem(
                icon: Icons.description,
                text: 'Terms of service',
                onTap: () {}),
            ProfileMenuItem(
                icon: Icons.privacy_tip, text: 'Privacy Policy', onTap: () {}),
            ProfileMenuItem(
                icon: Icons.logout, text: 'Log out', onTap: _logout),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Widget? trailing;

  const ProfileMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: onTap,
    );
  }
}
