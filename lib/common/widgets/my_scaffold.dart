import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final Color? color;
  const MyScaffold(
      {super.key, required this.child, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 96,
          color: color ?? const Color.fromRGBO(23, 86, 102, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 54),
              Text(
                title,
                style: TextStyle(fontSize: 28, color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          height: size.height - 96,
          child: child,
        ),
      ]),
    );
  }
}
