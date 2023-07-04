import 'package:chat_app/features/message/presentation/bloc/chat_item/chat_item_bloc.dart';
import 'package:chat_app/features/message/presentation/widgets/circle_message_item.dart';
import 'package:chat_app/features/message/presentation/widgets/item_message.dart';
import 'package:chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/helpers/app_assets.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../bloc/message/message_bloc.dart';

class MyMessageScreen extends StatelessWidget {
  const MyMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iconTinder,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Binder",
                style: TextStyle(
                  fontFamily: 'Grandista',
                  fontSize: 24,
                  color: Color.fromRGBO(223, 54, 64, 100),
                ),
              ),
            ],
          ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssets.iconShield,
              color: Colors.grey,
              width: 25,
            ),
          ),
        ],
      ),
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
                  search(context),
                  Container(
                    margin: const EdgeInsets.only(left: 20,top: 20,bottom: 10),
                    child: const Text(
                      'Tương hợp mới',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromRGBO(229, 58, 69, 100) ),
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: _buildChatRoomsList('horizontal', state.chatRoomsStream, state.currentUserId),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 20),
                    child: const Text(
                      'Tin nhắn',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromRGBO(229, 58, 69, 100) ),
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
