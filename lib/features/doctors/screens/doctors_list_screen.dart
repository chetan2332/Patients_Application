import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/common/utils/colors.dart';
import 'package:patient/features/doctors/controller/doctors_controller.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/features/chat/screens/reg_doctor_screen.dart';
import 'package:patient/features/doctors/widgets/doctor_card.dart';
import 'package:patient/common/widgets/drawer.dart';

class DoctorsListScreen extends ConsumerWidget {
  static const routeName = '/doctors-list-screen';
  const DoctorsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Doctors'),
        elevation: 0,
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<Doctor>>(
              stream: ref.watch(doctorsControllerProvider).getDoctorsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Doctor>? doctors = snapshot.data;
                if (doctors == null) {
                  return const Center(
                    child: Text('No data reached here'),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    child: DoctorCard(doctor: doctors[index]),
                    onTap: () {
                      Navigator.of(context).pushNamed(RegDoctorScreen.routeName,
                          arguments: doctors[index]);
                    },
                  ),
                  itemCount: doctors.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
