import 'package:ecommerce/apiLoginSignup/singUp.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'apiCourse1.1.dart';
import 'apiCourse1.2.dart';
import 'apiCourse1.3.dart';
import 'apiCourse1.3WoM.dart';
import 'apiCourse1.4Complexdata.dart';
import 'imageUpload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UploadImage(),
    );
  }
}
