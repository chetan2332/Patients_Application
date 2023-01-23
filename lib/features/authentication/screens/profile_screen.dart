import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/common/utils/colors.dart';
import 'package:patient/common/widgets/custom_button.dart';
import 'package:patient/common/widgets/drawer.dart';
import 'package:patient/features/authentication/controller/auth_controller.dart';
import 'package:patient/features/authentication/screens/login_screen.dart';
import 'package:patient/models/pateient.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  void signOut(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider).signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        // backgroundColor: greenColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProfileScreen.routeName);
              },
              icon: const Icon(Icons.mode_edit))
        ],
      ),
      body: FutureBuilder<Patient?>(
          future: ref.watch(authControllerProvider).getCurrentUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('No Profile Data Available'),
              );
            }
            Patient patientData = snapshot.data!;
            return Column(children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(patientData.profilePic),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        const Text('Name'),
                        Text(patientData.name),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: CustomButton(text: 'refresh', onPressed: refresh),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
                child: CustomButton(
                  text: 'SignOut',
                  onPressed: () => signOut(ref, context),
                ),
              ),
            ]);
          }),
    );
  }
}
