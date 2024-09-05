import 'package:flutter/material.dart';
import 'package:todo_mobil_app/screens/home.dart';

void main() {
  runApp(MyApp());
}

//setState kullanımı yapacağımız için StatelesWidget olmaz
//Checkbox ın içinde setState kullanacağız.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
