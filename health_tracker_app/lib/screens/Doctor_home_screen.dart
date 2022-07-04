import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_tracker/screens/appointment_screen.dart';
import 'package:health_tracker/screens/login_screen.dart';
import 'package:health_tracker/screens/reports_screen.dart';
import 'package:health_tracker/screens/reviews_screen.dart';
import 'package:health_tracker/screens/vitals_screen.dart';
class DoctorHomeScreen extends StatefulWidget {
  static String id = '/dochome';
  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
              children:[ Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50.0,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.25, -0.2),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 10, 10, 10),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFF95C1EC),
                            ),
                          ),
                          alignment: AlignmentDirectional(-0.85, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/images/output-onlinepngtools.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:[
                                            Text(
                                              'Mr. John Doe',
                                              style:
                                              TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            '45Y',
                                            style:
                                            TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontStyle: FontStyle.italic
                                            ),
                                          ),
                                          Text(' | ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25
                                            ),
                                          ),
                                          Text(
                                            'Male',
                                            style:
                                            TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 17
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ID: #23F3255466G',
                                            style:
                                            TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 17
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, VitalsScreen.id);
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/vitals.jpg',
                                        width: 45,
                                        height: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text('PATIENTS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, AppointmentScreen.id);
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/appointment.jpg',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text('APPOINTMENTS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, ReviewPage.id);
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/reviews.png',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text('REVIEWS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, ReportsScreenWidget.id);
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/health_report.jpg',
                                        width: 50,
                                        height: 50,

                                      ),
                                    ),

                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text('REPORTS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, LoginScreenWidget.id);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      child: Text('Log out',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      )
                  )
                ],
              ),
              ]
          ),
        ),
      ),
    );;
  }
}
