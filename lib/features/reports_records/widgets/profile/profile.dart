import 'package:flutter/material.dart';
import 'package:patient/features/reports_records/widgets/profile/different_texts.dart';
import 'package:patient/features/reports_records/widgets/profile/profile_block.dart';

import 'package:patient/models/doctor.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 13),
              GroupHeading('Common Details'),
              Divider(),
              ProfileBlock(title: 'Name', subtitle: 'Chetan Mahajan'),
              Divider(thickness: 0.7),
              ProfileBlock(title: 'Age', subtitle: '18'),
              Divider(thickness: 0.7),
              ProfileBlock(title: 'Gender', subtitle: 'Male'),
              Divider(thickness: 0.7),
              ProfileBlock(title: 'Blood Group', subtitle: 'B +ve'),
              SizedBox(height: 13),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              SizedBox(height: 13),
              GroupHeading('Blood Sugar Level'),
              Divider(),
              ProfileBlock2(title: 'Morning before breakfast', subtitle: '180'),
              Divider(thickness: 0.7),
              ProfileBlock2(title: 'After lunch', subtitle: '220'),
              Divider(thickness: 0.7),
              ProfileBlock2(title: 'After Dinner', subtitle: '210'),
              Divider(thickness: 0.7),
              ProfileBlock2(title: 'Date of Test', subtitle: '02/12/22'),
              Divider(thickness: 0.7),
              SizedBox(height: 13),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              SizedBox(height: 13),
              GroupHeading('Other Parameters'),
              Divider(),
              ProfileBlock2(title: 'Blood Pressure', subtitle: '70-120'),
              Divider(thickness: 0.7),
              ProfileBlock2(title: 'Heart Beat', subtitle: '68'),
              Divider(thickness: 0.7),
            ]),
      ),
    );
  }
}
