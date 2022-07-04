import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tracker/components.dart';
import 'package:health_tracker/screens/schedule_appointment_screen.dart';

class DoctorsScreenWidget extends StatefulWidget {
  const DoctorsScreenWidget({Key? key}) : super(key: key);
  static String id ='/doc';
  @override
  _DoctorsScreenWidgetState createState() =>
      _DoctorsScreenWidgetState();
}

class _DoctorsScreenWidgetState extends State<DoctorsScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Search Doctors',
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      color: Colors.teal,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
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
                            labelText: 'Search for doctors...',
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DoctorCard(
                            docName: 'Dr. Pranav',
                            docId: 'd23',
                            expertise: 'Radiologist',
                            image: 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DoctorCard(
                            docName: 'Dr Reshma',
                            docId: 'd45',
                            expertise: 'Cardiologist',
                            image: 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DoctorCard(
                            docName: 'Dr. Manoj',
                            docId: 'd32',
                            expertise: 'ENT specialist',
                            image: 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000'
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
    );
  }
}

