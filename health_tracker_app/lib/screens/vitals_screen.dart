import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/components.dart';
import 'package:health_tracker/utils/const.dart';
import 'package:health_tracker/widgets/card_items.dart';
import 'package:health_tracker/widgets/card_main.dart';
import 'package:health_tracker/widgets/card_section.dart';
import 'package:health_tracker/widgets/custom_clipper.dart';
import 'package:firebase_database/firebase_database.dart';

class VitalsScreen extends StatefulWidget {

  static String id = '/vitals';
  @override
  _VitalsScreenState createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
    final database = FirebaseDatabase.instance.reference();
    String hr = '-1';
    String ecg = '-1';
    @override
    void initState(){
      super.initState();
      NotificationApi.init();
      listenNotifications();
      activateListeners();
    }

    void listenNotifications() => NotificationApi.onNotifications.stream.listen(onClickedNotification);

    void onClickedNotification(String? payload){
      print('clicked');
    }

    void activateListeners(){
        database.ref.child("bpm/int").onValue.listen((event) {
          final Object? BPM = event.snapshot.value;
          setState(() {
            hr = BPM.toString();
          });
          if (int.parse(hr)>110){
            NotificationApi.showNotification(
                title: 'Alert!!',
                body: 'Patient\'s vitals have exceeded normal range!!',
                payload: 'alert'
            );
          }
          if (int.parse(hr)<50){
            NotificationApi.showNotification(
                title: 'Alert!!',
                body: 'Patient\'s vitals are below normal range!!',
                payload: 'alert'
            );
          }
          if (int.parse(ecg)>110){
            NotificationApi.showNotification(
                title: 'Alert!!',
                body: 'Patient\'s vitals have exceeded normal range!!',
                payload: 'alert'
            );
          }
          if (int.parse(ecg)<50){
            NotificationApi.showNotification(
                title: 'Alert!!',
                body: 'Patient\'s vitals are below normal range!!',
                payload: 'alert'
            );
          }
        });
        database.ref.child("ecg/int").onValue.listen((event) {
          final Object? ECG = event.snapshot.value;
          setState(() {
            ecg = ECG.toString();
          });
        });
    }
    @override
    Widget build(BuildContext context) { double statusBarHeight = MediaQuery.of(context).padding.top;
      return Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Container(
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyCustomClipper(clipType: ClipType.bottom),
                child: Container(
                  color: Colors.teal,
                  height: Constants.headerHeight + statusBarHeight,
                ),
              ),
              Positioned(
                right: -45,
                top: -30,
                child: ClipOval(
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    height: 220,
                    width: 220,
                  ),
                ),
              ),

              // BODY
              Padding(
                padding: EdgeInsets.all(Constants.paddingSide),
                child: ListView(
                  children: [
                    // Header - Greetings and Avatar
                    Row(
                      children: <Widget>[
                        if(LoginPressed.loginvalue==4)
                        Expanded(
                          child: Text("Hello,\nPatient",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.white
                            ),
                          ),
                        ),
                        if (LoginPressed.loginvalue==5)
                        Expanded(
                          child: Text("Hello,\nDoctor",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 50),

                    // Main Cards - Heartbeat and Blood Pressure
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 140,
                          child: CardMain(
                            image: AssetImage('assets/icons/heartbeat.png'),
                            title: "Hearbeat",
                            value: hr,
                            unit: "bpm",
                            color: Color(0xFFFAB2B2),
                            // color: Constants.lightGreen,
                          ),
                        ),
                      ],
                    ),

                    // Section Cards - Daily Medication
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardMain(
                            image: AssetImage('assets/images/ecg2.png'),
                            title: "ECG",
                            value: ecg,
                            unit: "mm/s",
                            color: Constants.lightGreen
                        ),
                      ],
                    ),

                    SizedBox(height: 50),

                    Text("DAILY MEDICATIONS",
                      style: TextStyle(
                        color: Constants.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                        height: 125,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            CardSection(
                              image: AssetImage('assets/icons/capsule.png'),
                              title: "Paracetamol",
                              value: "2",
                              unit: "pills",
                              time: "6-7AM",
                              isDone: false,
                            ),
                            CardSection(
                              image: AssetImage('assets/icons/syringe.png'),
                              title: "Insulin",
                              value: "1",
                              unit: "shot",
                              time: "8-9AM",
                              isDone: true,
                            )

                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }