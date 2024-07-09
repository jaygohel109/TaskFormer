import 'package:flutter/material.dart';
import 'package:taskformer/screens/login_screen.dart';
import 'package:taskformer/database/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    await _dbHelper.registerUser(username, password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User registered successfully')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Register.jpg',
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
                      errorStyle: TextStyle(color: Color.fromARGB(255, 248, 245, 245)),
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
                      errorStyle: TextStyle(color: Color.fromARGB(255, 248, 245, 245)),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 241, 238, 238)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text('Register', style: TextStyle(color: Color.fromARGB(255, 239, 231, 5))),
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
