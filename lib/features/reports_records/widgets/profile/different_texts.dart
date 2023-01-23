import 'package:flutter/material.dart';

class GroupHeading extends StatelessWidget {
  final String heading;

  const GroupHeading(this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 13),
        Text(
          heading,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
