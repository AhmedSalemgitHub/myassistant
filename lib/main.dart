import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myassistant/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'GUI/home.dart';
import 'utils/database_helper.dart';


void main() async {

  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      title: 'My Assistante'
    ),
);
}
