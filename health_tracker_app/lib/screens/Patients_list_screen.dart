import 'package:flutter/material.dart';
import 'package:health_tracker/screens/reports_screen.dart';
import 'package:health_tracker/screens/vitals_screen.dart';
import 'package:health_tracker/utils/const.dart';
import 'package:health_tracker/components.dart';

class PatientsListScreen extends StatelessWidget {
  static String id = '/plist';
  TextEditingController? textController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0, horizontal:18.0 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Search Patients',
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 8, 0),
                        child: TextFormField(
                          controller: textController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Search for patients...',
                            labelStyle:
                            TextStyle(
                              fontFamily: 'Product Sans',
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F4F8),
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            color: Color(0xFF1D2429),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 16, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.teal)

                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PatientCard(
                      patName: 'John Doe',
                      patId: 'p12',
                      age: '33',
                      image: 'https://flyclipart.com/thumb2/patient-vector-icon-122830.png',
                    vitalonPress: (){
                        Navigator.pushNamed(context, VitalsScreen.id);
                    },
                    reportonPress: (){
                        Navigator.pushNamed(context, ReportsScreenWidget.id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PatientCard(
                      patName: 'Stacy Bob',
                      patId: 'p32',
                      age: '45',
                      image: 'https://flyclipart.com/thumb2/patient-vector-icon-122830.png',
                    vitalonPress: (){
                      Navigator.pushNamed(context, VitalsScreen.id);
                    },
                    reportonPress: (){
                      Navigator.pushNamed(context, ReportsScreenWidget.id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PatientCard(
                      patName: 'Alice Philip',
                      patId: 'p17',
                      age: '57',
                      image: 'https://flyclipart.com/thumb2/patient-vector-icon-122830.png',
                    vitalonPress: (){
                      Navigator.pushNamed(context, VitalsScreen.id);
                    },
                    reportonPress: (){
                      Navigator.pushNamed(context, ReportsScreenWidget.id);
                    },

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
