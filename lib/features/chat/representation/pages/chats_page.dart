import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/chat/representation/cubits/chat/chat_cubit.dart';
import 'package:events_jo/features/chat/representation/cubits/chat/chat_states.dart';
import 'package:events_jo/features/chat/representation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsPage extends StatefulWidget {
  final AppUser user;

  const ChatsPage({
    super.key,
    required this.user,
  });

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final ChatCubit chatCubit;
  @override
  void initState() {
    super.initState();
    chatCubit = context.read<ChatCubit>();

    chatCubit.getUserChats(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<ChatCubit, ChatStates>(
              listener: (context, state) {
                if (state is ChatError) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (context, state) {
                if (state is ChatLoaded) {
                  final chats = state.chats;
                  return ListView.separated(
                    itemCount: chats.length,
                    separatorBuilder: (context, index) => 10.height,
                    itemBuilder: (context, index) {
                      return IconButton(
                        onPressed: () {
                          //todo add appbar,work on design of both pages, remove name change.
                          context.push(ChatPage(
                            currentUserId: widget.user.uid,
                            otherUserId: chats[index].participants.firstWhere(
                              (element) {
                                return element != widget.user.uid;
                              },
                            ),
                            currentUserName: widget.user.name,
                            otherUserName:
                                chats[index].participantsNames.firstWhere(
                              (element) {
                                return element != widget.user.name;
                              },
                            ),
                          ));
                        },
                        icon: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: null,
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    GColors.whiteShade3.shade600),
                              ),
                              icon: Icon(
                                Icons.person_rounded,
                                color: GColors.royalBlue,
                              ),
                            ),
                            10.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chats[index].participantsNames.firstWhere(
                                    (element) {
                                      return element != widget.user.name;
                                    },
                                  ),
                                  style: TextStyle(
                                    color: GColors.black,
                                    fontSize: kSmallFontSize,
                                  ),
                                ),
                                Text(
                                  chats[index].lastMessage,
                                  style: TextStyle(
                                    color: GColors.black.shade300,
                                    fontSize: kSmallFontSize,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              chats[index].lastUpdated.toString(),
                              style: TextStyle(
                                color: GColors.black.shade300,
                                fontSize: kSmallFontSize - 3,
                              ),
                            ),
                          ],
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
        ),
      ),
    );
  }
}
