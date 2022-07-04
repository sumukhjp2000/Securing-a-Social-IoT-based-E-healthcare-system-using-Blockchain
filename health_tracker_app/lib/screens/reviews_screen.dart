import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  static String id='/rev';
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool flag = true;
  String val = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: flag? TextField(
              onSubmitted: (value){
                print(value);
                setState(() {
                  val = value;
                  flag=false;
                });
              },
            ): Text(val),
          ),
        ),
      ),
    );
  }
}
