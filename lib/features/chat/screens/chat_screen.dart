import 'package:flutter/material.dart';
import 'package:patient/common/utils/colors.dart';
import 'package:patient/features/chat/widgets/bottom_chat_field.dart';
import 'package:patient/features/chat/widgets/chat_list.dart';
import 'package:patient/models/doctor.dart';

class ChatScreen extends StatelessWidget {
  final Doctor doctor;
  const ChatScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ChatList(doctor),
          ),
          BottomChatField(doctor),
        ],
      ),
    );
  }
}
