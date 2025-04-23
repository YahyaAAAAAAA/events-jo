import 'dart:async';
import 'package:events_jo/features/chat/domain/repo/chat_repo.dart';
import 'package:events_jo/features/chat/representation/cubits/message/message_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageStates> {
  final ChatRepo chatRepo;

  StreamSubscription? _messagesSubscription;

  MessageCubit({required this.chatRepo}) : super(MessageInitial());

  void getChatMessages(String currentUserId, String otherUserId) {
    _messagesSubscription = chatRepo
        .getMessages(currentUserId, otherUserId)
        .listen((messages) => emit(MessageLoaded(messages)));
  }

  void sendMessage({
    required String currentUserId,
    required String otherUserId,
    required String? currentUserName,
    required String? otherUserName,
    required String text,
  }) async {
    await chatRepo.sendMessage(
      senderId: currentUserId,
      receiverId: otherUserId,
      senderName: currentUserName,
      receiverName: otherUserName,
      text: text,
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
