import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/reports_records/screens/doctor_visit_screen.dart';
import 'package:patient/features/doctors/controller/doctors_controller.dart';
import 'package:patient/features/doctors/widgets/reg_doctor_card.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/common/widgets/drawer.dart';

class RegisteredDoctorsListScreen extends ConsumerStatefulWidget {
  static const routeName = '/registered-doctors';
  const RegisteredDoctorsListScreen({super.key});

  @override
  ConsumerState<RegisteredDoctorsListScreen> createState() =>
      _RegisteredDoctorsListScreenState();
}

class _RegisteredDoctorsListScreenState
    extends ConsumerState<RegisteredDoctorsListScreen> {
  List<Doctor> regDoctors = [];
  bool noPatientsRegistered = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref
        .read(doctorsControllerProvider)
        .getRegisteredDoctorsList()
        .then((value) {
      if (value != []) {
        noPatientsRegistered = false;
        setState(() {
          regDoctors = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registered Doctors',
          style: TextStyle(fontSize: 22),
        ),
        elevation: 0,
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: noPatientsRegistered
              ? const Center(
                  child: Text('You are not registered to any doctor'))
              : ListView.builder(
                  itemBuilder: ((context, index) => InkWell(
                        child: RegDoctorCard(doctor: regDoctors[index]),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            DoctorVisitScreen.routeName,
                            arguments: regDoctors[index],
                          );
                        },
                      )),
                  itemCount: regDoctors.length,
                ),
        )
      ]),
    );
  }
}
