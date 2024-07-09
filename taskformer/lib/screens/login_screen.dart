import 'package:flutter/material.dart';
import 'package:taskformer/screens/HomeScreen.dart';
import 'package:taskformer/screens/register_screen.dart';
import 'package:taskformer/database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await _dbHelper.loginUser(username, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Login.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 239, 231, 5)),
                      border: OutlineInputBorder(),
                      errorText: _usernameController.text.isEmpty ? 'Please enter a username' : null,
                      errorStyle: TextStyle(color: Color.fromARGB(255, 241, 239, 239)),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 241, 239, 239)),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 239, 231, 5)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 248, 245, 245)),
                      ),
                      errorText: _passwordController.text.isEmpty ? 'Please enter a password' : null,
                      errorStyle: TextStyle(color: Color.fromARGB(255, 241, 238, 238)),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 241, 238, 238)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login', style: TextStyle(color: Color.fromARGB(255, 230, 230, 24))),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Register', style: TextStyle(color: Color.fromARGB(255, 230, 182, 24))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}