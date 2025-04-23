import 'package:events_jo/features/chat/domain/models/chat.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class ChatLoading extends ChatStates {}

class ChatLoaded extends ChatStates {
  final List<Chat> chats;

  ChatLoaded(this.chats);
}

class ChatError extends ChatStates {
  final String message;

  ChatError(this.message);
}
