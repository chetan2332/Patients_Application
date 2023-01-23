import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/common/utils/utils.dart';
import 'package:patient/features/authentication/controller/auth_controller.dart';
import 'package:patient/models/pateient.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  static const routeName = '/edit-profile-screen';
  const EditProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  Patient patient = Patient(
    name: '',
    uid: '',
    profilePic:
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
    phoneNumber: '',
  );

  @override
  void initState() {
    super.initState();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void updateUserData() {
    if (nameController.text.isEmpty) {
      return;
    }
    ref.read(authControllerProvider).updateUserDataEveryWhere(
        context: context,
        photoUrl: patient.profilePic,
        name: nameController.text.trim(),
        profilePic: image);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: ref.read(authControllerProvider).getCurrentUserData(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                patient = snapshot.data!;
                nameController.text = patient.name;
              }
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Stack(
                        children: [
                          image == null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(patient.profilePic),
                                  radius: 64,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    image!,
                                  ),
                                  radius: 64,
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.85,
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your name',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: updateUserData,
                          icon: const Icon(
                            Icons.done,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
