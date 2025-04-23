import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/chat/domain/models/chat.dart';
import 'package:events_jo/features/chat/domain/models/message.dart';
import 'package:events_jo/features/chat/domain/repo/chat_repo.dart';

class FirebaseChatRepo implements ChatRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _chatDocId(String id1, String id2) {
    final ids = [id1, id2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  @override
  Stream<List<Message>> getMessages(String user1Id, String user2Id) {
    final chatId = _chatDocId(user1Id, user2Id);

    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromJson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String? senderName,
    required String? receiverName,
    required String text,
  }) async {
    final chatId = _chatDocId(senderId, receiverId);
    final chatDocRef = firestore.collection('chats').doc(chatId);
    final messagesRef = chatDocRef.collection('messages');

    final message = Message(
      id: '',
      senderId: senderId,
      text: text,
      timestamp: DateTime.now(),
    );

    //first time chat
    if (receiverName != null) {
      await chatDocRef.set({
        'participants': [senderId, receiverId],
        'participantsNames': [senderName, receiverName],
        'lastUpdated': FieldValue.serverTimestamp(),
        'lastMessage': text,
      }, SetOptions(merge: true));
    } else {
      //update metadata (won't overwrite existing fields)
      await chatDocRef.set({
        'participants': [senderId, receiverId],
        'lastUpdated': FieldValue.serverTimestamp(),
        'lastMessage': text,
      }, SetOptions(merge: true));
    }

    // Add message
    await messagesRef.add(message.toJson());
  }

  @override
  Future<List<Chat>> getUserChats(String currentUserId) async {
    final snapshot = await firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastUpdated', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return Chat.fromJson(doc.data());
    }).toList();
  }
}
