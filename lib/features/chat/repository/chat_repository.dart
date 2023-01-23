import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/common/utils/utils.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/message.dart';
import 'package:patient/models/pateient.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  ),
);

class ChatRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore firestore;

  ChatRepository(this._auth, this.firestore);

  Stream<List<Message>> getAllMessagesList(String doctorId) {
    final String userId = _auth.currentUser!.uid;
    return firestore
        .collection('patients/$userId/regDoctors/$doctorId/chats')
        .orderBy('timeSent')
        .snapshots()
        .map(
      (event) {
        List<Message> messages = [];
        for (var document in event.docs) {
          var message = document.data();
          messages.add(Message.fromMap(message));
        }
        return messages;
      },
    );
  }

  Stream<bool> isRegistered(String doctorId) {
    final String userId = _auth.currentUser!.uid;
    return firestore
        .collection('doctors/$doctorId/patients')
        .doc(userId)
        .snapshots()
        .map(
      (event) {
        if (event.data() == null || event.data()!['isRegistered'] == false) {
          return false;
        } else {
          return true;
        }
      },
    );
  }

  void registerUserToDoctor({
    required String doctorId,
    required BuildContext context,
    required bool isRegistered,
  }) async {
    try {
      var doctorDataDoc =
          await firestore.collection('doctors').doc(doctorId).get();
      final Doctor doctor = Doctor.fromMap(doctorDataDoc.data()!);
      final patientId = _auth.currentUser!.uid;
      _editDoctorIdToUserDataBase(doctorId, patientId, isRegistered, doctor);

      var userData =
          await firestore.collection('patients').doc(patientId).get();
      final Patient user = Patient.fromMap(userData.data()!);
      _editUserIdToDoctorDataBase(doctorId, patientId, isRegistered, user);
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String doctorId}) async {
    try {
      final String senderId = _auth.currentUser!.uid;
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      _updateLastMessage(
        text: text,
        doctorId: doctorId,
        patientId: senderId,
        timeSent: timeSent,
        messageId: messageId,
      );
      _saveTextMessageToPatientsDatabase(
        text: text,
        patientId: senderId,
        doctorId: doctorId,
        timeSent: timeSent,
        messageId: messageId,
      );
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  void _updateLastMessage(
      {required String text,
      required String doctorId,
      required String patientId,
      required DateTime timeSent,
      required String messageId}) async {
    await firestore
        .collection('doctors/$doctorId/patients/')
        .doc(patientId)
        .set(
      {
        'lastMessage': text,
        'senderId': patientId,
        'recieverId': doctorId,
        'timeSent': timeSent
      },
      SetOptions(merge: true),
    );
    await firestore
        .collection('patients/$patientId/regDoctors/')
        .doc(doctorId)
        .set(
      {
        'lastMessage': text,
        'senderId': patientId,
        'recieverId': doctorId,
        'timeSent': timeSent
      },
      SetOptions(merge: true),
    );
  }

  Future<void> _saveTextMessageToPatientsDatabase(
      {required String text,
      required String patientId,
      required String doctorId,
      required DateTime timeSent,
      required String messageId}) async {
    final Message message = Message(
        recieverId: doctorId,
        senderId: patientId,
        text: text,
        messageId: messageId,
        timeSent: timeSent);
    await firestore
        .collection('patients/$patientId/regDoctors/$doctorId/chats')
        .doc(messageId)
        .set(message.toMap());
  }

  void _editDoctorIdToUserDataBase(
      String doctorId, String userId, bool isRegistered, Doctor doctor) async {
    final userDatabase =
        firestore.collection('patients/$userId/regDoctors').doc(doctorId);
    if (!isRegistered) {
      await userDatabase.set(
        {
          'isRegistered': true,
          'name': doctor.name,
          'enrolled': doctor.enrolled,
          'profilePic': doctor.profilePic,
          'spec': doctor.specialization,
          'uid': doctor.uid,
        },
        SetOptions(merge: true),
      );
    } else {
      await userDatabase.set(
        {'isRegistered': false},
        SetOptions(merge: true),
      );
    }
  }

  void _editUserIdToDoctorDataBase(
      String doctorId, String userId, bool isRegistered, Patient user) async {
    final doctorDatabase =
        firestore.collection('doctors/$doctorId/patients').doc(userId);
    var data = await firestore.collection('doctors').doc(doctorId).get();
    if (!isRegistered) {
      await doctorDatabase.set(
        {
          'isRegistered': true,
          'name': user.name,
          'phoneNumber': user.phoneNumber,
          'profilePic': user.profilePic,
          'uid': user.uid,
        },
        SetOptions(merge: true),
      );
      firestore
          .collection('doctors')
          .doc(doctorId)
          .update({'enrolled': (data.data()!['enrolled'] ?? 0) + 1});
    } else {
      await doctorDatabase
          .set({'isRegistered': false}, SetOptions(merge: true));
      firestore.collection('doctors').doc(doctorId).set(
        {
          'enrolled': (data.data()!['enrolled'] ?? 1) - 1,
        },
        SetOptions(merge: true),
      );
    }
  }
}
