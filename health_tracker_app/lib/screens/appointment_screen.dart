import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/screens/doctors_screen.dart';
import 'package:health_tracker/components.dart';

class AppointmentScreen extends StatefulWidget {
  static String id = '/appt';
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:15.0, horizontal:18.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your Appointments',
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      color: Colors.teal,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:18.0, horizontal:18.0 ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      DefaultTabController(
                          length: 3, // length of tabs
                          initialIndex: 0,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: Colors.green,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Today'),
                                  Tab(text: 'Upcoming'),
                                  Tab(text: 'Past'),
                                ],
                              ),
                            ),
                            Container(
                                height: 400, //height of TabBarView
                                decoration: BoxDecoration(
                                    border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                                ),
                                child: TabBarView(children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Text('No appointments found.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text('No appointments found.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text('No appointments found.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ])
                            )
                          ])
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // if(LoginPressed.loginvalue==4)
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, DoctorsScreenWidget.id);
            //       },
            //       style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all(Colors.teal)
            //       ),
            //       child: Text('Schedule an Appointment',
            //         style: TextStyle(
            //           color: Colors.white,
            //             fontSize: 20
            //         ),
            //       )
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
