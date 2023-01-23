import 'package:flutter/material.dart';
import 'package:patient/common/utils/colors.dart';

class RegistratioScreen extends StatelessWidget {
  static const routeName = '/registration-screen';
  const RegistratioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill the form'),
        // backgroundColor: greenColor,
      ),
      body: const Center(
        child: Text('Registrstion Details'),
      ),
    );
  }
}
