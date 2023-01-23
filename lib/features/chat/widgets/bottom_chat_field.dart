import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/colors.dart';
import 'package:patient/features/chat/controller/chat_controller.dart';
import 'package:patient/models/doctor.dart';

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField(this.doctor, {super.key});
  final Doctor doctor;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  var focusNode = FocusNode();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void sendTextMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }
    ref.read(chatControllerProvider).sendTextMessage(
        context: context,
        text: _messageController.text.trim(),
        doctorId: widget.doctor.uid);
    setState(() {
      _messageController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: _messageController,
      decoration: InputDecoration(
          hintText: 'Send message',
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          // border:
          contentPadding: const EdgeInsets.all(10),
          suffix: TextButton(
            onPressed: sendTextMessage,
            child: const Text(
              'Send',
              style: TextStyle(color: Styles.appbarcolor),
            ),
          )),
    );
  }
}
