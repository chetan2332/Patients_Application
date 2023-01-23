import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/chat/controller/chat_controller.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/message.dart';

import 'my_message_card.dart';
import 'sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final Doctor doctor;
  const ChatList(this.doctor, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final messageController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .watch(chatControllerProvider)
            .getAllMessagesList(widget.doctor.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('No conversation begin till now'),
            );
          }

          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              controller: messageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                if (messageData.recieverId == widget.doctor.uid) {
                  return MyMessageCard(
                    message: messageData,
                  );
                }
                return SenderMessageCard(
                  message: messageData,
                );
              },
            ),
          );
        });
  }
}
