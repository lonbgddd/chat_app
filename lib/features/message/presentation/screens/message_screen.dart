import 'package:chat_app/features/message/presentation/bloc/chat_item/chat_item_bloc.dart';
import 'package:chat_app/features/message/presentation/widgets/circle_message_item.dart';
import 'package:chat_app/features/message/presentation/widgets/detail_Message.dart';
import 'package:chat_app/features/message/presentation/widgets/item_message.dart';
import 'package:chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/chat_room_entity.dart';
import '../bloc/detail_message/detail_message_bloc.dart';
import '../bloc/message/message_bloc.dart';

class MyMessageScreen extends StatelessWidget {
  const MyMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is ChatRoomsLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ChatRoomsLoading) {
          return const CircularProgressIndicator();
        }

        if (state is ChatRoomsLoaded) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 15),
                    child: Row(
                      children: [
                        const Text(
                          "Messages",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const Spacer(),
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              iconSize: 30,
                              padding: const EdgeInsets.all(5),
                              onPressed: () async {
                                context.go('/home/search-user');
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.pink,
                              ),
                            ))
                      ],
                    ),
                  ),
                  search(context),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      'Activities',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: _buildChatRoomsList('horizontal',
                        state.chatRoomsStream, state.currentUserId),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Messages',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SingleChildScrollView(
                    child: _buildChatRoomsList(
                        'vertical', state.chatRoomsStream, state.currentUserId),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildChatRoomsList(String direction,
      Stream<List<ChatRoomEntity>> stream, String currentUid) {
    return StreamBuilder<List<ChatRoomEntity>>(
      stream: stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('errr'),
          );
        }
        return snapshot.hasData
            ? ListView.builder(
                scrollDirection:
                    direction == 'vertical' ? Axis.vertical : Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                physics: direction == 'vertical'
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = snapshot.data?[index];
                  String uid = data!.chatRoomId
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(currentUid ?? "", "");
                  String chatRoomId = data.chatRoomId!;
                  return direction == 'vertical'
                      ? BlocProvider<ChatItemBloc>(
                          create: (context) => sl()
                            ..add(GetChatItem(
                                uid, snapshot.data![index].chatRoomId!)),
                          child: MyItemMessage(
                              uid: uid,
                              chatRoomId: snapshot.data![index].chatRoomId),
                        )
                      : BlocProvider<ChatItemBloc>(
                          create: (context) => sl()
                            ..add(GetChatItem(
                                uid, snapshot.data![index].chatRoomId!)),
                          child: CircleMessageItem(
                              uid: uid, chatRoomId: chatRoomId));
                },
              )
            : Container();
      },
    );
  }

  Widget search(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1, color: Colors.grey)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              onTap: () {
                context.go('/home/search-message');
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
