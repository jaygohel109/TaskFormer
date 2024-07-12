import 'package:flutter/material.dart';
import 'package:taskformer/Database/database_helper.dart';

class NotesScreen extends StatefulWidget {
  final String historicalLeader;

  const NotesScreen({Key? key, required this.historicalLeader}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final userId = await DatabaseHelper().getCurrentUserId();
    if (userId != null) {
      final notes = await DatabaseHelper().getNotes(userId, widget.historicalLeader);
      setState(() {
        _notes.addAll(notes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.historicalLeader}\'s Notes'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              final note = _notes[index];
              return Card(
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note['note'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note['timestamp'] as String,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
