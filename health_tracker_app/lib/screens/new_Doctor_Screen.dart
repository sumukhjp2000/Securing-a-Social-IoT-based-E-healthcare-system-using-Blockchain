import 'package:flutter/material.dart';
import 'package:health_tracker/components.dart';

class newDoctorScreen extends StatefulWidget {
  static String id ='/newDoc';
  @override
  _newDoctorScreenState createState() => _newDoctorScreenState();
}

class _newDoctorScreenState extends State<newDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DoctorCard(
          docName: 'Dr. Pranav',
          docId: '22',
          image: 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000',
          expertise: 'Cardiologist',
        ),
      ),
    );
  }
}
