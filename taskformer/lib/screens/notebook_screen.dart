import 'package:flutter/material.dart';
import 'package:taskformer/Database/database_helper.dart';
import 'package:taskformer/screens/notes_screen.dart';

class NotebookScreen extends StatefulWidget {
  const NotebookScreen({Key? key}) : super(key: key);

  @override
  _NotebookScreenState createState() => _NotebookScreenState();
}

class _NotebookScreenState extends State<NotebookScreen> {
  final List<String> _historicalLeaders = [];

  @override
  void initState() {
    super.initState();
    _loadHistoricalLeaders();
  }

  Future<void> _loadHistoricalLeaders() async {
    final userId = await DatabaseHelper().getCurrentUserId();
    if (userId != null) {
      final leaders = await DatabaseHelper().getDistinctHistoricalLeaders(userId);
      setState(() {
        _historicalLeaders.addAll(leaders);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notebook'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _historicalLeaders.length,
            itemBuilder: (context, index) {
              final leader = _historicalLeaders[index];
              return Card(
                color: Colors.grey[850],
                child: ListTile(
                  title: Text(
                    leader,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.bookmark,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotesScreen(historicalLeader: leader),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
