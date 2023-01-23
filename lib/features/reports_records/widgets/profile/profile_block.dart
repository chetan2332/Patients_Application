import 'package:flutter/material.dart';
import 'package:patient/colors.dart';

class ProfileBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  const ProfileBlock({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          )
        ],
      )),
    );
  }
}

class ProfileBlock2 extends StatelessWidget {
  final String title;
  final String subtitle;
  const ProfileBlock2({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: SizedBox(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              )
            ],
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Edit',
                style: TextStyle(
                    color: Styles.appbarcolor, fontWeight: FontWeight.w600),
              ))
        ],
      )),
    );
  }
}
