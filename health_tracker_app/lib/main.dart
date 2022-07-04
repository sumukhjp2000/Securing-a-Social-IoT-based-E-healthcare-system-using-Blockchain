import 'package:flutter/material.dart';
import 'package:health_tracker/components.dart';
import 'package:health_tracker/screens/Doctor_home_screen.dart';
import 'package:health_tracker/screens/Out_of_location_screen.dart';
import 'package:health_tracker/screens/Patients_list_screen.dart';
import 'package:health_tracker/screens/appointment_screen.dart';
import 'package:health_tracker/screens/doctors_screen.dart';
import 'package:health_tracker/screens/Patient_home_screen.dart';
import 'package:health_tracker/screens/login_screen.dart';
import 'package:health_tracker/screens/new_Doctor_Screen.dart';
import 'package:health_tracker/screens/registration_screen.dart';
import 'package:health_tracker/screens/reports_screen.dart';
import 'package:health_tracker/screens/reviews_screen.dart';
import 'package:health_tracker/screens/schedule_appointment_screen.dart';
import 'package:health_tracker/screens/vitals_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart'

// Future _firebaseMessagingBackgroundHandler(Remote Message)



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationApi.init();
  // FirebaseMessaging.onBackgroundMessage((message) => null)
  runApp(HealthTracker());
}

class HealthTracker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreenWidget.id,
      routes: {
        HomePageWidget.id: (context) => HomePageWidget(),
        VitalsScreen.id: (context) => VitalsScreen(),
        AppointmentScreen.id: (context) => AppointmentScreen(),
        ReportsScreenWidget.id: (context) => ReportsScreenWidget(),
        DoctorsScreenWidget.id: (context) =>DoctorsScreenWidget(),
        RegScreenWidget.id: (context) =>RegScreenWidget(),
        LoginScreenWidget.id: (context) =>LoginScreenWidget(),
        ReviewPage.id: (context) =>ReviewPage(),
        ScheduleAppointmentScreen.id: (context) => ScheduleAppointmentScreen(),
        OutOfLocationScreen.id: (context) => OutOfLocationScreen(),
        DoctorHomeScreen.id: (context) => DoctorHomeScreen(),
        PatientsListScreen.id: (context) => PatientsListScreen(),
        newDoctorScreen.id: (context) => newDoctorScreen()
      },
    );
  }
}

