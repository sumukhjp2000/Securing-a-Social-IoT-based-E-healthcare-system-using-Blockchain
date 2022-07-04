import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tracker/components.dart';
import 'package:health_tracker/screens/Patients_list_screen.dart';
import 'package:health_tracker/screens/appointment_screen.dart';
import 'package:health_tracker/screens/doctors_screen.dart';
import 'package:health_tracker/screens/login_screen.dart';
import 'package:health_tracker/screens/reports_screen.dart';
import 'package:health_tracker/screens/reviews_screen.dart';
import 'package:health_tracker/screens/vitals_screen.dart';
import 'package:health_tracker/screens/registration_screen.dart';
import 'package:health_tracker/components.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_tracker/utils/blockchain_functions.dart';
import 'package:health_tracker/utils/const.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class HomePageWidget extends StatefulWidget {

  static String id='/Home';
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Web3Client? ethClient;
  Client? httpClient;


  @override
  void initState(){
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(Constants.infura_url, httpClient!);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                    // ElevatedButton(onPressed: () async{
                    //   await Future.delayed(Duration(seconds: 2));
                    //   print(Constants.walletAddress);
                    //   List<dynamic> showdata = await checkIsPatientLogged(Constants.walletAddress, ethClient!);
                    //   print(showdata);
                    //   name = showdata[0];
                    //   age = showdata[1];
                    //   id = showdata[2];
                    //   gender = showdata[3];
                    //   setState(() {
                    //   });
                    // }, child: Icon(
                    //     Icons.refresh,
                    // )
                    //
                    // ),
                    if(LoginPressed.loginvalue==4)
                    IconButton(onPressed: () async{
                        // await Future.delayed(Duration(seconds: 2));
                          print(Constants.walletAddress);

                          List<dynamic> showdata = await checkIsPatientLogged(
                              Constants.walletAddress, ethClient!);
                          print(showdata);
                          if (showdata.isNotEmpty) {
                            setState(() {
                              Constants.displayName = showdata[0];
                              Constants.displayAge = showdata[1];
                              Constants.displayId = showdata[2];
                              Constants.displayGender = showdata[3];
                            });
                          }
                          if (showdata.isEmpty) {
                            print(Constants.name);
                            print(Constants.age);
                            print(Constants.gender);
                            setState(() {
                              Constants.displayName = Constants.name;
                              Constants.displayAge = Constants.age;
                              Constants.displayGender = Constants.gender;
                            });
                          }

                    },
                        icon: Icon(Icons.refresh,
                        color: Colors.white,
                        )
                    ),
                    if(LoginPressed.loginvalue==5)
                    IconButton(onPressed: () async{
                      // await Future.delayed(Duration(seconds: 2));
                      print(Constants.walletAddress);

                      List<dynamic> showdata = await checkIsDoctorLogged(
                          Constants.walletAddress, ethClient!);
                      print(showdata);
                      if (showdata.isNotEmpty) {
                        setState(() {
                          Constants.displayName = showdata[0];
                          Constants.displayAge = showdata[1];
                          Constants.displayId = showdata[2];
                          Constants.displayGender = showdata[3];
                        });
                      }
                      if (showdata.isEmpty) {
                        print(Constants.name);
                        print(Constants.age);
                        print(Constants.gender);
                        setState(() {
                          Constants.displayName = Constants.name;
                          Constants.displayAge = Constants.age;
                          Constants.displayGender = Constants.gender;
                        });
                      }

                    },
                        icon: Icon(Icons.refresh,
                          color: Colors.white,
                        )
                    )
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
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:[
                                        Text(
                                          'Name:',
                                          style:
                                          TextStyle(
                                              fontSize:17,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic
                                          ),
                                        ),
                                        Text(
                                          ' ${Constants.displayName}',
                                          style:
                                          TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic
                                          ),
                                        ),
                                        // ConstrainedBox(
                                        //   constraints: BoxConstraints(
                                        //     maxHeight: 40,
                                        //     maxWidth: 150
                                        //   ),
                                        //   child: Text(
                                        //     ' ${Constants.displayName}',
                                        //     style:
                                        //     TextStyle(
                                        //         fontSize: 20,
                                        //         fontWeight: FontWeight.bold,
                                        //       fontStyle: FontStyle.italic
                                        //     ),
                                        //   ),
                                        // ),
                                      ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Age: ${Constants.displayAge}',
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
                                          'Sex: ${Constants.displayGender}',
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
                                          'ID: ${Constants.displayId}',
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
                                  if (LoginPressed.loginvalue==4)
                                  Navigator.pushNamed(context, VitalsScreen.id);
                                  if (LoginPressed.loginvalue==5)
                                    Navigator.pushNamed(context, PatientsListScreen.id);
                                },
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                              if(LoginPressed.loginvalue==4)
                                Text('VITALS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                ),
                              ),
                              if(LoginPressed.loginvalue==5)
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
                                    padding: const EdgeInsets.all(10.0),
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
                    if(LoginPressed.loginvalue==4)
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
                                  Navigator.pushNamed(context, DoctorsScreenWidget.id);
                                },
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/Doctor.jpg',
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
                              Text('DOCTORS',
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
                                    padding: const EdgeInsets.all(12.0),
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
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text('Log Out',
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

    );

  }
}



