import 'package:flutter/material.dart';
import 'package:patient/colors.dart';
import 'package:patient/features/authentication/screens/profile_screen.dart';
import 'package:patient/features/chat/screens/chat_screen.dart';
import 'package:patient/features/reports_records/screens/reports_screen.dart';
import 'package:patient/features/reports_records/widgets/profile/profile.dart';
import 'package:patient/models/doctor.dart';

class DoctorVisitScreen extends StatelessWidget {
  static const String routeName = '/doctors-visit-screen';

  final List<Tab> myTabs = const [
    Tab(text: 'Profile'),
    Tab(text: 'Reports'),
    Tab(text: 'Chats'),
  ];

  TabBar get _tabBar => TabBar(
        indicatorColor: Styles.appbarcolor,
        labelColor: Colors.black,
        tabs: myTabs,
      );

  final Doctor doctor;

  const DoctorVisitScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (context) {
        return Scaffold(
          // backgroundColor: Styles.scaffoldbackgroundcolor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Styles.scaffoldbackgroundcolor,
                elevation: 0,
                child: _tabBar,
              ),
            ),
            title: Text(
              'Dr. ${doctor.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: TabBarView(children: [
            DoctorProfile(doctor: doctor),
            ReportsScreen(doctor: doctor),
            ChatScreen(doctor: doctor)
          ]),
        );
      }),
    );
  }
}
