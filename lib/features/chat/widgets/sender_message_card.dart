import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/colors.dart';
import 'package:patient/models/message.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          // minWidth: 110,
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Styles.appbarcolor.withOpacity(0.88),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, top: 5, bottom: 26),
                child: Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 10,
                child: Text(
                  DateFormat.Hm().format(message.timeSent),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[400],
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
