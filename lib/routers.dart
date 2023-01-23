import 'package:flutter/material.dart';
import 'package:patient/features/authentication/screens/profile_screen.dart';
import 'package:patient/features/authentication/screens/user_information_screen.dart';
import 'package:patient/features/reports_records/screens/reports_screen.dart';
import 'package:patient/features/reports_records/screens/doctor_visit_screen.dart';
import 'package:patient/features/doctors/screens/doctors_list_screen.dart';
import 'package:patient/features/reports_records/widgets/reports/category_reports.dart';
import 'package:patient/features/reports_records/widgets/reports/monthly_reports.dart';
import 'package:patient/screens/error_screen.dart';
import 'package:patient/features/authentication/screens/login_screen.dart';
import 'package:patient/features/chat/screens/reg_doctor_screen.dart';
import 'package:patient/features/doctors/screens/registered_doctors_list_screen.dart';
import 'package:patient/features/doctors/screens/registration_screen.dart';
import 'features/authentication/screens/edit_profile_screen.dart';
import 'features/authentication/screens/signUp_screen.dart';
import 'models/doctor.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const UserInformationScreen());

    case DoctorsListScreen.routeName:
      return MaterialPageRoute(builder: (context) => const DoctorsListScreen());

    case RegisteredDoctorsListScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const RegisteredDoctorsListScreen());

    case DoctorVisitScreen.routeName:
      final doctor = settings.arguments as Doctor;
      return MaterialPageRoute(
          builder: (context) => DoctorVisitScreen(doctor: doctor));

    case RegDoctorScreen.routeName:
      Doctor doctor = settings.arguments as Doctor;
      return MaterialPageRoute(builder: (context) => RegDoctorScreen(doctor));

    case ReportsScreen.routeName:
      var doctor = settings.arguments as Doctor;
      return MaterialPageRoute(
          builder: (context) => ReportsScreen(doctor: doctor));

    case RegistratioScreen.routeName:
      return MaterialPageRoute(builder: (context) => const RegistratioScreen());

    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());

    case EditProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const EditProfileScreen());
    case MonthlyReport.routeName:
      var val = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => MonthlyReport(val));
    case CategoryReports.routeName:
      var val = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => CategoryReports(val));

    default:
      return MaterialPageRoute(
        builder: (context) =>
            const ErrorScreen(error: 'This page doesn\'t exist'),
      );
  }
}
