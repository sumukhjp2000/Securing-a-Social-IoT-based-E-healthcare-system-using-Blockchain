import 'package:health_tracker/screens/login_screen.dart';
import 'Patient_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:health_tracker/utils/const.dart';
import 'package:health_tracker/utils/blockchain_functions.dart';

class RegScreenWidget extends StatefulWidget {
  const RegScreenWidget({Key? key}) : super(key: key);
  static String id ='/reg';
  @override
  _RegScreenWidgetState createState() => _RegScreenWidgetState();
}

class _RegScreenWidgetState extends State<RegScreenWidget> {
  Client? httpClient;
  Web3Client? ethClient;
  int count=0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController confirmPasswordController;
  late bool confirmPasswordVisibility;
  late TextEditingController walletAddressController;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController passwordController;
  late TextEditingController genderController;
  late bool passwordVisibility;
  late bool value = false;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(Constants.infura_url, httpClient!);
    super.initState();
    nameController = TextEditingController();
    genderController = TextEditingController();
    ageController = TextEditingController();
    confirmPasswordController = TextEditingController();
    confirmPasswordVisibility = false;
    walletAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }
  Future register() async {

    if (value == false) {
      List<dynamic> auth = await registerPatient(
          walletAddressController.text, nameController.text,
          passwordController.text, ageController.text,
          genderController.text, ethClient!);

      Constants.name = nameController.text;
      Constants.age = ageController.text;
      Constants.gender = genderController.text;
      if(walletAddressController.text == Constants.walletAddress){
        auth[0] = false;
        print('Same Wallet address');

      }
      Constants.walletAddress = walletAddressController.text;
      Constants.password = passwordController.text;
      walletAddressController.clear();
      nameController.clear();
      passwordController.clear();
      ageController.clear();
      genderController.clear();
      confirmPasswordController.clear();

      Navigator.of(context).pop();
      if (auth[0] == true) {
        Navigator.pushNamed(context, LoginScreenWidget.id);
      }
      else {
        print('Entering false');
        showDialog(context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Wallet Address in use!', style: TextStyle(color: Colors.red),),
                content: Text('Please enter a new wallet address.'),
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
        // Navigator.pushNamed(context, LoginScreenWidget.id);
        // SnackBar(
        // content: Text('Invalid Details'),
        // );
      }

    }
    else {
      if (value == true) {
        List<dynamic> auth = await registerDoctor(
            walletAddressController.text, nameController.text,
            passwordController.text, ageController.text,
            genderController.text, ethClient!);
        if(walletAddressController.text == Constants.walletAddress){
          auth[0] = false;
          print('Doctor - Same wallet address');
        }
        Constants.name = nameController.text;
        Constants.age = ageController.text;
        Constants.gender = genderController.text;
        Constants.walletAddress = walletAddressController.text;


        walletAddressController.clear();
        nameController.clear();
        passwordController.clear();
        ageController.clear();
        genderController.clear();
        confirmPasswordController.clear();

        Navigator.of(context).pop();
        if (auth[0] == true) {
          Navigator.pushNamed(context, LoginScreenWidget.id);
        }
        else {
          print('Entering false');
          showDialog(context: context,
              builder: (context){
                return AlertDialog(
                  title: Text('Wallet Address in use!', style: TextStyle(color: Colors.red),),
                  content: Text('Please enter a new wallet address.'),
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

          // SnackBar(
          // content: Text('Invalid Details'),
          // );
        }
        auth.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Color(0xFFF1F4F8),
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF0F1113),
                          size: 24,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF0F1113),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 10, 0, 0),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0F1113),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Text(
                              'Create your account by filling in the information below to access the app.',
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 14, 24, 0),
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
                        controller: nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Your name...',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter your name',
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 14, 24, 0),
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
                        controller: ageController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Your age...',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter your age',
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 14, 24, 0),
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
                        controller: walletAddressController,
                        obscureText: false,
                        decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(
                                left: 20.0,
                                bottom: 10.0,
                                top: 10.0),
                          labelText: 'Your wallet address...',
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 14, 24, 0),
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
                        controller: genderController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Your gender...',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter your Gender',
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
                        controller: passwordController,
                        obscureText: !passwordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Please enter your password',
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
                                  () => passwordVisibility = !passwordVisibility,
                            ),
                            child: Icon(
                              passwordVisibility
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
                        controller: confirmPasswordController,
                        obscureText: !confirmPasswordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Please enter your password',
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
                                  () => confirmPasswordVisibility =
                              !confirmPasswordVisibility,
                            ),
                            child: Icon(
                              confirmPasswordVisibility
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

                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: value,
                        onChanged: (value){
                          setState(() {
                            this.value = value!;
                          });
                        }
                    ),
                    Text('I am a Doctor',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF0F1113),
                        fontWeight: FontWeight.normal,
                    )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator());
                      }
                  );
                  try{
                    register();
                  }
                  finally{
                    await Future.delayed(Duration(seconds: 5));
                    register();
                    await Future.delayed(Duration(seconds: 5));
                    register();
                    await Future.delayed(Duration(seconds: 5));
                    register();
                    await Future.delayed(Duration(seconds: 5));
                    register();
                  }
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),

                  ),
                  child: Text('Create Account',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                    ),
                  )
              )
            ],
          ),
        ),
      );
  }
}
