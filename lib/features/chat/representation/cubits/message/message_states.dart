import 'package:events_jo/features/chat/domain/models/message.dart';

abstract class MessageStates {}

class MessageInitial extends MessageStates {}

class MessageLoading extends MessageStates {}

class MessageLoaded extends MessageStates {
  final List<Message> messages;

  MessageLoaded(this.messages);
}

class MessageError extends MessageStates {
  final String message;

  MessageError(this.message);
}
