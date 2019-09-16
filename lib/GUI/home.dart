import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myassistant/GUI/student_input_screen.dart';
import 'package:myassistant/models/student.dart';
import 'package:myassistant/utils/database_helper_students.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  //final myPassedData;

  //Home(this.myPassedData);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();

  List<Student> items = List();
  StudentDatabaseHelper db = StudentDatabaseHelper();

  @override
  void initState() {
    db.initDB();
    db.getAll().then((students) {
      setState(() {
        students.forEach((students) {
          items.add(Student.fromMap(students));
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.yellow,
            child: ListTile(
              title: Text('${items[position].name}'),
              trailing: IconButton(
                  icon:Icon( Icons.delete_forever,color: Colors.red,),
                  onPressed: _delete(items[position],position)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return StudentInputScreen(Student("","","",0));
            }
          ));
        },
      ),
    );
  }

  _delete(Student student,int position) async{
    db.deleteStudent(student.id).then((student){
      setState(() {
        items.removeAt(position);
      });
    });
  }
}
