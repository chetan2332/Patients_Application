import 'package:flutter/material.dart';
import 'package:patient/features/authentication/controller/auth_controller.dart';
import 'package:patient/common/widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final password = TextEditingController();

  void onSignIn() {
    if (emailController.text.isNotEmpty && password.text.isNotEmpty) {
      ref.read(authControllerProvider).loginWithEmail(
            email: emailController.text,
            password: password.text,
            context: context,
          );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(text: 'login', onPressed: onSignIn),
              CustomButton(
                  text: 'SignUp Instead',
                  onPressed: () {
                    // Navigator.of(context)
                    //     .pushReplacementNamed(SignUpScreen.routeName);
                  }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
