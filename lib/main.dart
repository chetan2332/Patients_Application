// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/common/utils/colors.dart';
import 'package:patient/features/authentication/controller/auth_controller.dart';
import 'package:patient/features/authentication/screens/login_screen.dart';
import 'package:patient/features/doctors/screens/registered_doctors_list_screen.dart';
import 'package:patient/routers.dart';
import 'package:patient/screens/error_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ref.watch(userDataProvider).when(
          data: (user) {
            if (user == null) {
              return const LoginScreen();
            }
            return const RegisteredDoctorsListScreen();
          },
          error: (error, stackTrace) {
            return ErrorScreen(error: error.toString());
          },
          loading: () => const Center(child: CircularProgressIndicator())),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xFF013e3f),
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light),
          backgroundColor: Color(0xFF013e3f),
          elevation: 0,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
