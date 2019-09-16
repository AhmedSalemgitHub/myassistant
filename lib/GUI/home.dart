import 'package:flutter/material.dart';
import 'package:myassistant/GUI/student_input_screen.dart';
import 'package:myassistant/models/student.dart';
import 'package:myassistant/utils/database_helper_students.dart';

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
  void dispose() {
db.dbClose();
super.dispose();
  }
  @override
  void initState() {
    super.initState();
    db.getAll().then((students) {
      setState(() {
        students.forEach((students) {
          items.add(Student.fromMap(students));
        });
      });
    });

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
              subtitle: Text('class: ${items[position].classRoom} - telephone: ${items[position].mobile}'),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: (){
                  setState(() {
                    db.deleteStudent(items[position].id);
                    items.removeAt(position);
                  });
                },
              ),
              onTap: (){},
            )
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()async {
          String result = await Navigator.push(context,
              MaterialPageRoute(
                builder: (context)=> StudentInputScreen(Student("", "", "", 0)),
              ),
          );

          if(result == 'save'){
            db.getAll().then((students){
              setState(() {
                items.clear();
                students.forEach((student){
                  items.add(Student.fromMap(student));
                });
              });
            });
          }
        },

      ),
    );
  }
}
