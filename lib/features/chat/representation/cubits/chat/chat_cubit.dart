import 'package:events_jo/features/chat/domain/repo/chat_repo.dart';
import 'package:events_jo/features/chat/representation/cubits/chat/chat_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  final ChatRepo chatRepo;

  ChatCubit({required this.chatRepo}) : super(ChatInitial());

  Future<void> getUserChats(String userId) async {
    emit(ChatLoading());
    try {
      final chats = await chatRepo.getUserChats(userId);
      emit(ChatLoaded(chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
