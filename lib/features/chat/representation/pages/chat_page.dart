import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/chat/representation/cubits/message/message_cubit.dart';
import 'package:events_jo/features/chat/representation/cubits/message/message_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String? currentUserName;
  final String? otherUserName;

  const ChatPage({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    this.currentUserName,
    this.otherUserName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late final MessageCubit chatCubit;

  @override
  void initState() {
    super.initState();
    chatCubit = context.read<MessageCubit>();

    chatCubit.getChatMessages(widget.currentUserId, widget.otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.otherUserName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageCubit, MessageStates>(
              builder: (context, state) {
                if (state is MessageLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId == widget.currentUserId;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const GlobalLoadingBar();
                }
              },
            ),
          ),
          //bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      chatCubit.sendMessage(
                        text: text,
                        currentUserId: widget.currentUserId,
                        otherUserId: widget.otherUserId,
                        currentUserName: widget.currentUserName,
                        otherUserName: widget.otherUserName,
                      );
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
