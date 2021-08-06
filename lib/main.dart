import 'package:flutter/material.dart';
import 'package:intern_assignment/screens/imagePickerScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veda Enterprises',
      theme: ThemeData(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(brightness: Brightness.dark),
      ),
      home: ImagePickerScreen(),
    );
  }
}
