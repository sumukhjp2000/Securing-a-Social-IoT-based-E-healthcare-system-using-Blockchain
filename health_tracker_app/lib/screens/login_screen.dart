
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:health_tracker/screens/Out_of_location_screen.dart';
import 'package:web3dart/web3dart.dart';
import 'Patient_home_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:health_tracker/components.dart';
import 'package:health_tracker/components.dart';
import 'package:health_tracker/utils/const.dart';
import 'package:health_tracker/utils/blockchain_functions.dart';
import 'package:http/http.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);
  static String id ='/login';
  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  Web3Client? ethClient;
  Client? httpClient;
  double? lat;
  double? long;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController emailAddressController;
  late TextEditingController passwordLoginController;
  late bool passwordLoginVisibility;

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(Constants.infura_url, httpClient!);
    super.initState();
    emailAddressController = TextEditingController();
    passwordLoginController = TextEditingController();
    passwordLoginVisibility = false;
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium, forceAndroidLocationManager: false);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset:true,
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Health Tracker',
                textStyle: TextStyle(
                  fontFamily: 'Hind',
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,

                ),),
            ],
          ),
          SizedBox(
            height:20
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                    child: Text(
                      'Access your account by logging in below.',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'User wallet address',
                  labelStyle: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Enter your wallet address',
                  hintStyle: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsetsDirectional.fromSTEB(20, 10, 10, 0),
                ),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: passwordLoginController,
                obscureText: !passwordLoginVisibility,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Please enter your password...',
                  hintStyle: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                          () => passwordLoginVisibility = !passwordLoginVisibility,
                    ),
                    child: Icon(
                      passwordLoginVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xFF57636C),
                      size: 22,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: ElevatedButton(
                onPressed: () async{

                  showDialog(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator());
                      }
                  );

                  LoginPressed.button(4);

                  List<dynamic> login = await loginPatient(emailAddressController.text, passwordLoginController.text, ethClient!);
                  Constants.walletAddress=emailAddressController.text;
                  Constants.password = passwordLoginController.text;
                  // Navigator.of(context).pop();
                  if (login[0]==true) {
                    try {
                      //Loading details
                      print(Constants.walletAddress);

                      List<dynamic> showdata = await checkIsPatientLogged(
                          Constants.walletAddress, ethClient!);
                      print(showdata);

                      setState(() {
                        Constants.displayName = showdata[0];
                        Constants.displayAge = showdata[1];
                        Constants.displayId = showdata[2];
                        Constants.displayGender = showdata[3];
                      });
                      Navigator.of(context).pop();
                      emailAddressController.clear();
                      passwordLoginController.clear();
                      Navigator.pushNamed(context, HomePageWidget.id);

                    }
                    catch (e) {
                      print(Constants.name);
                      print(Constants.age);
                      print(Constants.gender);
                      setState(() {
                        Constants.displayName = Constants.name;
                        Constants.displayAge = Constants.age;
                        Constants.displayGender = Constants.gender;
                      });
                      Navigator.of(context).pop();
                      emailAddressController.clear();
                      passwordLoginController.clear();
                      Navigator.pushNamed(context, HomePageWidget.id);
                    }

                  }
                  else {
                    emailAddressController.clear();
                    passwordLoginController.clear();
                    print(login[0]);
                    Navigator.of(context).pop();
                    showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Invalid credentials!', style: TextStyle(color: Colors.red),),
                              content: Text('Please enter valid credentials.'),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });

                  }

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),

                ),
                child: Text('Login as a Patient',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                  ),
                )
            )
          ),
          Padding(

              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: ElevatedButton(
                  onPressed: () async{

                    showDialog(
                        context: context,
                        builder: (context){
                          return Center(child: CircularProgressIndicator());
                        }
                    );

                    LoginPressed.button(5);
                    Position pos = await _getGeoLocationPosition();
                    double lat = pos.latitude;
                    double long = pos.longitude;
                    print('lat: ${pos.latitude}');
                    print('long:${pos.longitude}');
                    print('short lat ${lat.toStringAsFixed(4)}');
                    print('short long ${long.toStringAsFixed(4)}');
                    List<dynamic> loc = await CheckLoc(
                          lat.toStringAsFixed(4), long.toStringAsFixed(4),
                          ethClient!);
                    //Check Location
                      if (loc[0] == true) {

                        List<dynamic> login = await loginDoctor(
                            emailAddressController.text,
                            passwordLoginController.text, ethClient!);
                        Constants.walletAddress = emailAddressController.text;
                        //Check login
                        if (login[0] == true) {
                        try {
                          //Loading details
                          print(Constants.walletAddress);

                          List<dynamic> showdata = await checkIsDoctorLogged(
                              Constants.walletAddress, ethClient!);
                          print(showdata);

                          setState(() {
                            Constants.displayName = showdata[0];
                            Constants.displayAge = showdata[1];
                            Constants.displayId = showdata[2];
                            Constants.displayGender = showdata[3];
                          });
                          Navigator.of(context).pop();
                          emailAddressController.clear();
                          passwordLoginController.clear();
                          Navigator.pushNamed(context, HomePageWidget.id);
                        }
                        catch (e) {
                          print(Constants.name);
                          print(Constants.age);
                          print(Constants.gender);
                          setState(() {
                            Constants.displayName = Constants.name;
                            Constants.displayAge = Constants.age;
                            Constants.displayGender = Constants.gender;

                          });
                          Navigator.of(context).pop();
                          emailAddressController.clear();
                          passwordLoginController.clear();
                          Navigator.pushNamed(context, HomePageWidget.id);
                        }
                        }
                      else {
                        emailAddressController.clear();
                        passwordLoginController.clear();
                        Navigator.of(context).pop();
                        showDialog(context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text('Invalid Credentials!', style: TextStyle(color: Colors.red),),
                                content: Text('Please enter valid credentials'),
                                actions: [
                                  MaterialButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                  }
                       else {
                        // 13.027478304822738, 77.55828968203585 - Home
                        // 12.907845369769165, 77.5661429002567 - College
                        // if(lat>=13.025 && lat<=13.030 && long>=77.553 && long<=77.563){
                        if(lat>=12.90765 && lat<=12.9080 && long>=77.5659 && long<=77.5664){
                          List<dynamic> login = await loginDoctor(

                              emailAddressController.text,
                              passwordLoginController.text, ethClient!);
                          Constants.walletAddress = emailAddressController.text;

                          if (login[0] == true) {
                            try {
                              List<dynamic> showdata = await checkIsDoctorLogged(
                                  Constants.walletAddress, ethClient!);
                              print(showdata);
                              setState(() {
                                Constants.displayName = showdata[0];
                                Constants.displayAge = showdata[1];
                                Constants.displayId = showdata[2];
                                Constants.displayGender = showdata[3];
                              });
                              Navigator.of(context).pop();
                              emailAddressController.clear();
                              passwordLoginController.clear();
                              Navigator.pushNamed(context, HomePageWidget.id);
                            }
                            catch(e) {
                                print(Constants.name);
                                print(Constants.age);
                                print(Constants.gender);
                                setState(() {
                                  Constants.displayName = Constants.name;
                                  Constants.displayAge = Constants.age;
                                  Constants.displayGender = Constants.gender;
                                });
                                Navigator.of(context).pop();
                                emailAddressController.clear();
                                passwordLoginController.clear();
                              Navigator.pushNamed(context, HomePageWidget.id);
                            }
                          }
                          else {
                            emailAddressController.clear();
                            passwordLoginController.clear();
                            print(login[0]);
                            Navigator.of(context).pop();
                            showDialog(context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text('Invalid Credentials!', style: TextStyle(color: Colors.red),),
                                    content: Text('Please enter valid credentials'),
                                    actions: [
                                      MaterialButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          }

                        }
                        else{

                          emailAddressController.clear();
                          passwordLoginController.clear();
                          Navigator.of(context).pop();
                          showDialog(context: context,
                              builder: (context){
                            return AlertDialog(
                              title: Text('Alert!', style: TextStyle(color: Colors.red),),
                              content: Text('User not in required location!'),
                              actions: [
                                MaterialButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                  child: Text('OK'),
                                    ),
                              ],
                            );
                          });
                          // Navigator.pushNamed(context, OutOfLocationScreen.id);
                        }

                      }




                    // List<dynamic> login = await loginDoctor(emailAddressController.text, passwordLoginController.text, ethClient!);
                    // Constants.walletAddress=emailAddressController.text;
                    // if (login[0]==true)
                    //   Navigator.pushNamed(context, HomePageWidget.id);
                    // else {
                    //   emailAddressController.clear();
                    //   passwordLoginController.clear();
                    //   print(login[0]);
                    // }
                    // Position pos = await _getGeoLocationPosition();
                    // print('lat: ${pos.latitude}');
                    // print('long:${pos.longitude}');
                    // // Navigator.pushNamed(context, HomePageWidget.id);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),

                  ),
                  child: Text('Login as a Doctor',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white
                    ),
                  )
              ),

          ),
          // Visibility(
          //   child: IconButton(
          //     icon: Icon(Icons.refresh),
          //     onPressed: () async{
          //       LoginPressed.button(5);
          //       Navigator.pushNamed(context, HomePageWidget.id);
          //     },
          //   ),
          //   maintainSize: true,
          //   maintainAnimation: true,
          //   maintainState: true,
          //   visible: true,
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child:  MaterialButton(
                onPressed: (){
                  Navigator.pushNamed(context,RegScreenWidget.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New here?',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey
                      ),
                    ),
                    Text('Create Account',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                          color: Colors.black
                      ),
                    ),
                  ],
                )
            )
          ),
        ],
      ),
    );
  }
}
