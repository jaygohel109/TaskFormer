import 'package:flutter/material.dart';
import 'package:taskformer/screens/home_screen.dart';
import 'package:taskformer/screens/register_screen.dart';
import 'package:taskformer/database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? _usernameError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _usernameError =
          _usernameController.text.isEmpty ? 'Please enter a username' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Please enter a password' : null;
    });

    if (_usernameError == null && _passwordError == null) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final user = await _dbHelper.loginUser(username, password);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Login.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.7],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.black45.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.yellow),
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      if (_usernameError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            _usernameError!,
                            style: const TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.yellow),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.yellow),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors
                          //     .yellow, // Set the background color to yellow
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16, // Set the font size
                            color: Colors.yellow, // Set the text color to black
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
