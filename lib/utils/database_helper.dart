import 'dart:io';
import 'package:myassistant/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static Database _db;
  final String usersTable = 'usersTable';
  final String columnID = 'id';
  final String columnUserName = 'username';
  final String columnPassword = 'password';
  final String columneMail = 'email';
  final String columnAge = 'age';


  Future<Database> get db async{
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async{
    Directory documentDirectory = await getApplicationSupportDirectory();
    String path = join(documentDirectory.path , 'mydb.db');
    var myOwnDB = await openDatabase(path,version: 1,onCreate: _onCreate);
    return myOwnDB;
      }
    
  _onCreate(Database database,int newVersion) async{
    var sql = "CREATE TABLE $usersTable ($columnID INTEGER PRIMARY KEY,"
     "$columnUserName TEXT, "
     "$columnPassword TEXT, "
     "$columneMail TEXT, "
     "$columnAge INTEGER)";

    await database.execute(sql);
  }

  Future<int> saveUser(User user)async{
    var dbClient = await db;
    int result = await dbClient.insert(usersTable, user.toMap());
    return result;
  }

  Future<List> getAll()async{
    var dbClient = await db;
    var sql = 'SELECT * FROM $usersTable';
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  Future<int> getCount()async{
    var dbClient = await db;
    var sql = 'SELECT COUNT(*)FROM $usersTable';
    return Sqflite.firstIntValue(
      await dbClient.rawQuery(sql)
    );
  }

  Future<User> getUser(int id)async{
    var dbClient = await db;
    var sql = 'SELECT * FROM $usersTable WHERE $columnID = $id';
    var result = await dbClient.rawQuery(sql);

    if (result.length == 0) {
      return null;
    }
    return User.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
      usersTable,
      where: "$columnID = ?",
      whereArgs: [id]);
  }

  Future<int> updateUser(User user) async{
    var dbClient = await db;
    return await dbClient.update(
      usersTable,
      user.toMap(),
      where: "$columnID = ?",
      whereArgs: [user.id]
      );
  }

  Future<void> dbclose() async{
    var dbClient = await db;
    return await dbClient.close();
  }

}