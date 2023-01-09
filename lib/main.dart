import 'package:flutter/material.dart';
import 'package:my_first_app/screen/Wellcome.dart';

void main() {
  runApp(MyApp());
}

// Class name stessless widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
      theme: ThemeData(primarySwatch: Colors.deepOrange),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

//state = name widget
class _MyWidgetState extends State<MyWidget> {
  @override
//แสดงผล
  @override
  Widget build(BuildContext context) {
    //data widget
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: WellcomeScreen());
  }
}
