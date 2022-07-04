import 'package:flutter/material.dart';

class OutOfLocationScreen extends StatelessWidget {
  static String id = '/outofloc';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text('ALERT!!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User not in location range!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
