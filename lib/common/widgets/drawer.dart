import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/colors.dart';
import 'package:patient/features/authentication/controller/auth_controller.dart';
import 'package:patient/features/authentication/screens/login_screen.dart';
import 'package:patient/features/authentication/screens/profile_screen.dart';
import 'package:patient/features/doctors/screens/doctors_list_screen.dart';
import 'package:patient/features/doctors/screens/registered_doctors_list_screen.dart';
import 'package:patient/info.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({Key? key}) : super(key: key);

  void signOut(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider).signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }

  Widget buildListTile(IconData icon, String title, Function tapHandler) =>
      ListTile(
        leading: Icon(
          icon,
          size: 24,
          color: Styles.appbarcolor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          tapHandler();
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).canvasColor,
      width: MediaQuery.of(context).size.width * 0.72,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Heading(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
              Icons.medical_information_outlined, 'Registered Doctors', () {
            Navigator.of(context)
                .pushReplacementNamed(RegisteredDoctorsListScreen.routeName);
          }),
          buildListTile(Icons.all_inclusive_sharp, 'All Doctors', () {
            Navigator.of(context)
                .pushReplacementNamed(DoctorsListScreen.routeName);
          }),
          const Expanded(child: SizedBox()),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              size: 24,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),
            ),
            onTap: () {
              signOut(ref, context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 26)
        ],
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 36),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(myProfileImage),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              const Text(
                'Chetan Mahajan',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              const Text(
                'chetan@gmail.com',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ProfileScreen.routeName);
                  },
                  child: const Text(
                    'View Profile',
                    style: TextStyle(
                        color: Styles.appbarcolor, fontWeight: FontWeight.w600),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
