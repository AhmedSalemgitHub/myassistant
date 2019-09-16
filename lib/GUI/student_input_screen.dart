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
  TextEditingController _idController;

  @override
  void initState() {

     _nameController = TextEditingController(text: widget.passedStudent.name);
     _classController = TextEditingController(text: widget.passedStudent.classRoom);
     _ageController = TextEditingController(text: widget.passedStudent.age.toString());
     _mobileController = TextEditingController(text: widget.passedStudent.mobile);
     _idController = TextEditingController(text: widget.passedStudent.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('input'),
      ),
      body: Container(
        height: 300,
        width: 300,
        color: Colors.green,
      ),
    );
  }

}