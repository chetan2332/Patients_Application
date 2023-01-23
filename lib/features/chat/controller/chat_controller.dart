import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/authentication/controller/auth_controller.dart';
import 'package:patient/features/chat/repository/chat_repository.dart';
import 'package:patient/models/message.dart';
import 'package:patient/models/pateient.dart';

final chatControllerProvider = Provider(
  (ref) {
    final chatRepository = ref.watch(chatRepositoryProvider);
    return ChatController(chatRepository, ref);
  },
);

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  late Patient user;

  ChatController(this.chatRepository, this.ref) {
    ref.read(userDataProvider).whenData((value) => user = value!);
  }

  void registerUserToDoctor(
      String doctorId, BuildContext context, bool isRegistered) {
    chatRepository.registerUserToDoctor(
        doctorId: doctorId, context: context, isRegistered: isRegistered);
  }

  Stream<bool> isRegistered(String doctorId) {
    return chatRepository.isRegistered(doctorId);
  }

  Stream<List<Message>> getAllMessagesList(String doctorId) {
    return chatRepository.getAllMessagesList(doctorId);
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String doctorId,
  }) {
    chatRepository.sendTextMessage(
        context: context, text: text, doctorId: doctorId);
  }
}
