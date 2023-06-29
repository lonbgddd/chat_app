import 'package:chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_item/chat_item_bloc.dart';
import '../bloc/detail_message/detail_message_bloc.dart';
import 'detail_message.dart';

class CircleMessageItem extends StatelessWidget {
  const CircleMessageItem(
      {super.key, required this.uid, required this.chatRoomId});

  final String uid;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatItemBloc, ChatItemState>(
      listenWhen: (previous, current) => current is ChatItemActionState,
      buildWhen: (previous, current) => current is! ChatItemActionState,
      listener: (context, state) {
        if (state is ChatItemClicked) {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return BlocProvider<DetailMessageBloc>(
                    create: (context) => sl()..add(GetMessageList(chatRoomId!)),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.95,
                        child: DetailMessage(
                          uid: uid,
                          chatRoomId: chatRoomId,
                          name: state.user.fullName,
                          avatar: state.user.avatar,
                          token: state.user.token,
                        )));
              });
          BlocProvider.of<ChatItemBloc>(context)
              .add(GetChatItem(uid!, chatRoomId!));
        }
      },
      builder: (context, state) {
        if (state is ChatItemLoaded) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<ChatItemBloc>(context)
                  .add(ShowDetail(state.user));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 70,
              height: 70,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(state.user.avatar ?? ""),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        state.user.fullName ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
    ;
  }
}
