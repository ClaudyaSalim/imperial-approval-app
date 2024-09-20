import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:imperial_approval_app/model/user_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper{

  Database? db;
  DatabaseFactory? dbFactory;

  Future initDb() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'approval.db');

    if(db==null){
      await makeDb(path);
      await initUsers();
      print("db has been created");
    }
    else {
      print("db is there");
    }
    
  }

  Future makeDb (String path) async{
    await deleteDatabase(path);

    if(Platform.isWindows){
      db = await dbFactory!.openDatabase(path);
      await onCreateWeb(db!);
    }

    else {
      db = await openDatabase(path, version: 1, onCreate: onCreate);
    }

  }

  Future onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT, div TEXT, position TEXT, role TEXT)');
  }

  Future onCreateWeb(Database db) async {
    await db.execute(
      'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT, div TEXT, position TEXT, role TEXT)');
  }

  Future initUsers() async{
    // var user1 = {'name' : 'test', 'email' : 'test@gmail.com', 'password' : 'test123', 'div' : 'IT', 'position' : 'Staff', 'role' : 'user'};
    var user1 = User(name: 'test', email: 'test@gmail.com', password: 'test123', div: 'IT', position: 'Staff', role: 'user');
    await db!.insert('users', user1.toMap());
  }

  Future getUsers() async {
    await initDb();
    var listUsers = await db!.query('users');

    List<User> users = [];

    if(listUsers.isNotEmpty){
      users = listUsers.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    }
    else {
      print("Users is empty!");
    }

    for (var user in users) {
      print(user.email);
    }
  }
}