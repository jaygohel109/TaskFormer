import 'package:flutter/material.dart';
import 'package:taskformer/screens/openai_service.dart';
import 'package:taskformer/Database/database_helper.dart';

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

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final userId = await DatabaseHelper().getCurrentUserId();
    if (userId != null) {
      final messages = await DatabaseHelper().getMessages(userId, widget.personName);
      setState(() {
        _messages.addAll(messages.map((msg) => {
          'text': msg['message'] as String,
          'sender': msg['sender'] as String,
        }));
      });
    }
  }

  Future<void> _sendMessage(String message) async {
    final userId = await DatabaseHelper().getCurrentUserId();
    if (userId != null) {
      setState(() {
        _messages.add({'text': message, 'sender': 'user'});
      });
      _controller.clear();

      try {
        final response = await openAIService.sendMessage(message, widget.personName);
        setState(() {
          _messages.add({'text': response, 'sender': widget.personName});
        });
        await DatabaseHelper().saveMessage(userId, message, 'user', widget.personName);
        await DatabaseHelper().saveMessage(userId, response, widget.personName, widget.personName);

        // Generate and save notes
        final notes = await openAIService.generateNotes(_messages);
        print('Generated notes: $notes');
        await DatabaseHelper().saveNotes(userId, widget.personName, notes);
      } catch (error) {
        _showError('Connection failed: $error');
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
      body: SafeArea(
        child: Container(
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
                                style: const TextStyle(color: Colors.black),
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
                padding: const EdgeInsets.all(15.0),
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
      ),
    );
  }
}
