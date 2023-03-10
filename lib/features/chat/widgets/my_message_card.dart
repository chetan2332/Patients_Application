import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/models/message.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // color: senderMessageColor,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 10, top: 5, bottom: 20),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                left: 10,
                child: Text(
                  DateFormat.Hm().format(message.timeSent),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
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
