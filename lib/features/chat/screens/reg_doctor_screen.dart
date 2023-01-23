// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/common/utils/colors.dart';
import 'package:patient/features/chat/controller/chat_controller.dart';
import 'package:patient/common/widgets/custom_button.dart';
import 'package:patient/info.dart';
import 'package:patient/models/doctor.dart';

class RegDoctorScreen extends ConsumerWidget {
  static const routeName = 'reg-doc-screen';
  final Doctor doctor;
  const RegDoctorScreen(this.doctor, {super.key});

  void register(
    String doctorId,
    WidgetRef ref,
    bool isRegistered,
    BuildContext context,
  ) {
    ref
        .read(chatControllerProvider)
        .registerUserToDoctor(doctorId, context, isRegistered);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. ${doctor.name}'),
        // backgroundColor: greenColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 300,
            child: CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(doctorProfilePic),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: myButton(ref),
          )
        ]),
      ),
    );
  }

  StreamBuilder<bool> myButton(WidgetRef ref) {
    return StreamBuilder<bool>(
      stream: ref.watch(chatControllerProvider).isRegistered(doctor.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == null) {
          return const Text('data not reached here');
        } else if (snapshot.data!) {
          return CustomButton(
            onPressed: () => register(doctor.uid, ref, snapshot.data!, context),
            text: 'Cancel Registration',
            color: Colors.red[400]!,
          );
        } else {
          return CustomButton(
            onPressed: () => register(doctor.uid, ref, snapshot.data!, context),
            text: 'Register',
          );
        }
      },
    );
  }
}
