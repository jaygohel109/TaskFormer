import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');
    print('Database path: $path'); // Log the database path

    return openDatabase(
      path,
      version: 3, // Increment the version number
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Add this line
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL,
      password TEXT NOT NULL
    )
    ''');
    await db.execute('''
    CREATE TABLE messages (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      message TEXT NOT NULL,
      sender TEXT NOT NULL,
      timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
      historical_leader TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users (id)
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('''
      ALTER TABLE messages ADD COLUMN historical_leader TEXT NOT NULL DEFAULT 'Unknown'
      ''');
    }
  }

  Future<int> registerUser(String username, String password) async {
    final db = await database;
    return await db.insert('users', {'username': username, 'password': password});
  }

  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setInt('user_id', maps.first['id']);

      return maps.first;
    }
    return null;
  }

  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('user_id');
  }

  Future<void> saveMessage(int userId, String message, String sender, String historicalLeader) async {
    final db = await database;
    await db.insert('messages', {
      'user_id': userId,
      'message': message,
      'sender': sender,
      'timestamp': DateTime.now().toIso8601String(),
      'historical_leader': historicalLeader
    });
  }

  Future<List<Map<String, dynamic>>> getMessages(int userId, String historicalLeader) async {
    final db = await database;
    return await db.query(
      'messages',
      where: 'user_id = ? AND historical_leader = ?',
      whereArgs: [userId, historicalLeader],
      orderBy: 'timestamp ASC'
    );
  }
}
