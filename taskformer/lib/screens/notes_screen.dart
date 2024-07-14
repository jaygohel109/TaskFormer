import 'package:flutter/material.dart';
import 'package:taskformer/Database/database_helper.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  final String historicalLeader;

  const NotesScreen({Key? key, required this.historicalLeader}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, dynamic>> _dailyNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final userId = await DatabaseHelper().getCurrentUserId();
    if (userId != null) {
      final notes = await DatabaseHelper().getNotes(userId, widget.historicalLeader);
      final Map<String, String> aggregatedNotes = {};

      for (var note in notes) {
        String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(note['timestamp'] as String));
        String noteText = note['note'] as String;

        if (aggregatedNotes.containsKey(date)) {
          aggregatedNotes[date] = '${aggregatedNotes[date]}\n$noteText';
        } else {
          aggregatedNotes[date] = noteText;
        }
      }

      setState(() {
        aggregatedNotes.forEach((date, summary) {
          _dailyNotes.add({
            'date': date,
            'summary': summary,
          });
        });
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
            itemCount: _dailyNotes.length,
            itemBuilder: (context, index) {
              final note = _dailyNotes[index];
              return Card(
                color: Colors.grey[850],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note['date'] as String,
                        style: const TextStyle(color: Colors.yellow, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note['summary'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
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

