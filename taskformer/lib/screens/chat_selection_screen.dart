import 'package:flutter/material.dart';
import 'openai_service.dart';

void main() => runApp(HistoricalChatApp());

class HistoricalChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historical Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatSelectionScreen(),
    );
  }
}

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
      {'name': 'Marie Curie', 'image': 'assets/images/marie_curie.jpg'},
      {'name': 'Thomas Edison', 'image': 'assets/images/Thomas_Edison.png'},
    ];

    return Scaffold(
      appBar: AppBar(
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
              height: 300,
              child: PageView.builder(
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
              ),
              child: const Text('Select'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatCard(BuildContext context, String name, String imageUrl, double scale) {
    return Transform.scale(
      scale: scale,
      child: Column(
        children: [
          Image.asset(imageUrl, height: 200),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String personName;
  final String personImage;

  const ChatScreen({Key? key, required this.personName, required this.personImage}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final OpenAIService openAIService = OpenAIService('YOUR_API_KEY'); // Replace with your actual API key

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'text': message, 'sender': 'user'});
    });
    _controller.clear();

    try {
      final response = await openAIService.sendMessage(message, widget.personName);
      setState(() {
        _messages.add({'text': response, 'sender': 'bot'});
      });
    } catch (error) {
      _showError('Connection failed: $error');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.personName} Chat'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message['sender'] == 'user';
                  return Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.yellow : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUserMessage)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                widget.personImage,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              message['text']!,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 11, 10, 10),
                        hintText: 'Ask me anything...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _sendMessage(_controller.text);
                      }
                    },
                    backgroundColor: Colors.yellow,
                    child: const Icon(Icons.send, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
