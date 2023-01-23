import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/authentication/repository/auth_repository.dart';
import 'package:patient/models/pateient.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return Authcontroller(authRepository, ref);
});

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getCurrentUserData();
});

class Authcontroller {
  final AuthRepository authRepository;
  final ProviderRef ref;
  Authcontroller(this.authRepository, this.ref);

  void signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) {
    authRepository.signUpWithEmail(
        email: email, password: password, context: context);
  }

  void loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) {
    authRepository.loginWithEmail(
        context: context, email: email, password: password);
  }

  void signOut() {}

  Future<Patient?> getCurrentUserData() {
    return authRepository.getCurrentUserData();
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  void updateUserDataEveryWhere({
    required String name,
    required File? profilePic,
    required String photoUrl,
    required BuildContext context,
  }) {
    authRepository.updateUserDataEveryWhere(
        name: name,
        profilePic: profilePic,
        photoUrl: photoUrl,
        ref: ref,
        context: context);
  }
}
