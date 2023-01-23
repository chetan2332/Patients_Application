import 'package:flutter/material.dart';
import 'package:patient/colors.dart';
import 'package:patient/common/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = greenColor});

  final String text;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
            // disabledBackgroundColor: greenColor,
            backgroundColor: Styles.appbarcolor,
            minimumSize: const Size(double.infinity, 50)),
        child: Text(
          text,
          style: const TextStyle(color: backgroundColor),
        ),
      ),
    );
  }
}
