import 'package:events_jo/features/chat/domain/models/chat.dart';
import 'package:events_jo/features/chat/domain/models/message.dart';

abstract class ChatRepo {
  Stream<List<Message>> getMessages(String user1Id, String user2Id);
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String? senderName,
    required String? receiverName,
    required String text,
  });
  Future<List<Chat>> getUserChats(String currentUserId);
}
