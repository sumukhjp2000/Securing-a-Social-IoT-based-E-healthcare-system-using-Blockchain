import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget cardchild;
  final double height;
  // final Function tap;
  ReusableCard({required this.colour,required this.cardchild,required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: tap(),
      child: Container(
        child: cardchild,
        height: height,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file){
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch(e){
      return null;
    }
  }
  static UploadTask? uploadBytes(String destination, Uint8List data){
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putData(data);
    } on FirebaseException catch(e){
      return null;
    }
  }
}

class LoginPressed {
  static var loginvalue;
  static void button(int id) {
    loginvalue = id;
    print('pressed $loginvalue');
  }
}

class NotificationApi{
  static final FlutterLocalNotificationsPlugin _notifications= FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static Future _notificationDetails () async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        importance: Importance.max
      ),
    );
  }
  static Future init({bool initScheduled =false}) async{
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');

    final settings = InitializationSettings(android: android);
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async{
        onNotifications.add(payload);
      },
    );
  }

  static Future showNotification({
  int id=1,
  String? title,
  String? body,
  String? payload
}) async => _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload
  );
}

class DoctorCard extends StatelessWidget{
  final String docName;
  final String docId;
  final String expertise;
  final String image;
  DoctorCard({required this.docName, required this.docId, required this.expertise, required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 160,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              6.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
          color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 4, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.05, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                        docName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  Text(
                    'ID: $docId',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    expertise,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                          alignment: AlignmentDirectional(-0.05, 0),
                          child: SizedBox(
                            width: 140,
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF17A28E)),
                              ),
                              onPressed: () {
                                print('BookAppointment pressed ...');
                              },
                              child: Text('Book Appointment',
                                style:
                                TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 12,
                                ),

                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class PatientCard extends StatelessWidget{
  final String patName;
  final String patId;
  final String age;
  final String image;
  void Function()? vitalonPress;
  void Function()? reportonPress;
  PatientCard({required this.patName, required this.patId, required this.age, required this.image, required this.vitalonPress, required this.reportonPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 160,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                6.0, // Move to right 10  horizontally
                3.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 4, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.05, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                        patName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  Text(
                    'ID: $patId',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  Text(
                    'Age: $age',
                    style: TextStyle(
                        fontSize: 14,
                    ),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                          alignment: AlignmentDirectional(-0.05, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 40,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF17A28E)),
                                  ),
                                  onPressed: vitalonPress,
                                  child: Text('View Vitals',
                                    style:
                                    TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),

                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 90,
                                height: 40,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF17A28E)),
                                  ),
                                  onPressed: reportonPress,
                                  child: Text('View Reports',
                                    style:
                                    TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}