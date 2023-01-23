import 'package:flutter/material.dart';
import 'package:patient/colors.dart';
import 'package:patient/info.dart';
import 'package:patient/models/doctor.dart';

class RegDoctorCard extends StatelessWidget {
  final Doctor doctor;
  const RegDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width,
        height: 175,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: size.width * 0.36,
                  height: 136,
                  child: const CircleAvatar(
                      backgroundImage: NetworkImage(doctorProfilePic)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${doctor.name}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 7),
                    Text(doctor.specialization),
                    // Text('Enrolled: ${doctor.enrolled.toString()}'),
                    // Text('Red No.: ${doctor.regNo}'),
                  ],
                ),
              ),
              const Spacer()
            ]),
            const SizedBox(height: 18),
            Container(
              color: Styles.appbarcolor,
              height: 0.7,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
