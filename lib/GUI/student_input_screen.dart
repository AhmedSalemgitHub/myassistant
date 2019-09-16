import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myassistant/models/student.dart';
import 'package:myassistant/utils/database_helper_students.dart';


class StudentInputScreen extends StatefulWidget{

  final Student passedStudent;

  StudentInputScreen(this.passedStudent);

  @override
  State<StatefulWidget> createState() {
    return _StudentInputState();
  }

}

class _StudentInputState extends State<StudentInputScreen>{

  StudentDatabaseHelper db = StudentDatabaseHelper();

  TextEditingController _nameController;
  TextEditingController _classController;
  TextEditingController _ageController;
  TextEditingController _mobileController;

  @override
  void initState() {

    super.initState();

     _nameController = TextEditingController(text: widget.passedStudent.name);
     _classController = TextEditingController(text: widget.passedStudent.classRoom);
     _ageController = TextEditingController(text: widget.passedStudent.age.toString());
     _mobileController = TextEditingController(text: widget.passedStudent.mobile);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('input'),
      ),
      body: Container(
        margin: EdgeInsets.all(8),

        color: Colors.green,
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.pinkAccent,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'name:',
                  labelStyle: TextStyle(color: Colors.amber),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            TextField(
              controller: _classController,
              decoration: InputDecoration(
                labelText: 'class',
                labelStyle: TextStyle(color: Colors.amber),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: 'mobile',
                labelStyle: TextStyle(color: Colors.amber),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'age',
                labelStyle: TextStyle(color: Colors.amber),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            RaisedButton(
              child: (widget.passedStudent.id != null) ? Text('update') :Text('save'),
              onPressed: (){

                  if(widget.passedStudent.id != null){
                    db.updateStudent(Student.fromMap(
                        {
                          'id' : widget.passedStudent.id,
                          'name' : _nameController.text,
                          'class' : _classController.text,
                          'mobile' : _mobileController.text,
                          'age' : int.parse(_ageController.text)
                        }
                    )).then((_){
                      Navigator.pop(context,'update');
                    });
                  }else{
                    db.saveStudent(Student(_nameController.text,
                        _classController.text,
                        _mobileController.text,
                        int.parse(_ageController.text)
                    )).then((_){
                      Navigator.pop(context,'save');
                    });
                  }
              })
          ],
        ),
      ),
    );
  }

}