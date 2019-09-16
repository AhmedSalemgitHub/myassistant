import 'dart:io';
import 'package:myassistant/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class StudentDatabaseHelper{

  static Database _db;
  final String studentTable = 'studentsTable';
  final String columnID = 'id';
  final String columnStudentName = 'student';
  final String columnMobile = 'mobile';
  final String columnClassRoom = 'class';
  final String columnAge = 'age';

  ///create the database , and check if it exist first.
  Future<Database> get db async{
    //check db exist or not
    if (_db != null) {
      return _db;
    }

    ///create the data base using the [initDB] function
    _db = await initDB();
    return _db;
  }

  ///the function creates the db
  initDB() async{
    //the path inside the device
    Directory documentDirectory = await getApplicationSupportDirectory();
    //add the file name to the path
    String path = join(documentDirectory.path , 'mydb.db');
    //open the db
    var myOwnDB = await openDatabase(path,version: 1,onCreate: _onCreate);
    return myOwnDB;
      }

  ///the function is required inside the open database function
  _onCreate(Database database,int newVersion) async{
    var sql = "CREATE TABLE $studentTable ($columnID INTEGER PRIMARY KEY,"
     "$columnStudentName TEXT, "
     "$columnMobile TEXT, "
     "$columnClassRoom TEXT, "
     "$columnAge INTEGER)";

    await database.execute(sql);
  }

  ///creating the [CRUD] functions
  ///this is the create function
  Future<int> saveStudent(Student student)async{
    //first connect to the database
    var dbClient = await db;
    //use the insert function , it ask for the table name,
    // then the values as list.
    int result = await dbClient.insert(studentTable, student.toMap());
    return result;
  }

  ///getAll the data inside the database
  Future<List> getAll()async{
    var dbClient = await db;
    var sql = 'SELECT * FROM $studentTable';
    List result = await dbClient.rawQuery(sql);
    return result.toList();
  }

  ///to get the count of all the rows inside the table
  Future<int> getCount()async{
    var dbClient = await db;
    var sql = 'SELECT COUNT(*)FROM $studentTable';
    return Sqflite.firstIntValue(
      await dbClient.rawQuery(sql)
    );
  }

  ///get the data of a specific item by its update
  Future<Student> getStudent(int id)async{
    var dbClient = await db;
    var sql = 'SELECT * FROM $studentTable WHERE $columnID = $id';
    var result = await dbClient.rawQuery(sql);

    if (result.length == 0) {
      return null;
    }
    return Student.fromMap(result.first);
  }

  ///delete a specific item by its update
  Future<int> deleteStudent(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
      studentTable,
      where: "$columnID = ?",
      whereArgs: [id]);
  }

  ///update the data of a specific id
  Future<int> updateStudent(Student student) async{
    var dbClient = await db;
    return await dbClient.update(
      studentTable,
      student.toMap(),
      where: "$columnID = ?",
      whereArgs: [student.id]
      );
  }

  ///close the connection to the database
  Future dbClose() async{
    var dbClient = await db;
    return await dbClient.close();
  }
}