import 'package:flutter/material.dart';
import 'package:taskformer/services/chat_service.dart'; // Ensure ChatService is imported

class ChatbotPopup extends StatefulWidget {
  const ChatbotPopup({Key? key}) : super(key: key);

  @override
  _ChatbotPopupState createState() => _ChatbotPopupState();
}

class _ChatbotPopupState extends State<ChatbotPopup> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': _controller.text});
      _controller.clear(); // Clear the input field immediately after sending the message
    });

    try {
      final response = await _chatService.sendMessage(_messages.last['content']!);
      setState(() {
        _messages.add({'role': 'bot', 'content': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'content': 'Failed to get a response. Please try again later.'});
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
      content: Container(
        width: double.maxFinite,
        height: 500, // Adjust the height as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/logo_pastport.png', // Make sure to update the path as per your asset location
                height: 60, // Adjust the height as needed
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      alignment: _messages[index]['role'] == 'user' ? Alignment.topRight : Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: _messages[index]['role'] == 'user' ? Color.fromARGB(255, 255, 228, 77) : Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          _messages[index]['content']!,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 20, 18, 18),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                        fillColor: Color.fromARGB(255, 40, 40, 31),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Color.fromARGB(255, 234, 215, 49), size: 50),
                      onPressed: _sendMessage,
                    ),
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
