
import 'package:chat_app/features/message/domain/entities/user_entity.dart';
import 'package:chat_app/features/message/presentation/bloc/chat_item/chat_item_bloc.dart';
import 'package:chat_app/features/message/presentation/screens/search_Message.dart';
import 'package:chat_app/features/message/presentation/widgets/circle_message_item.dart';
import 'package:chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/helpers/app_assets.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../bloc/message/message_bloc.dart';
import '../bloc/search_chatroom/search_chatroom_bloc.dart';
import '../bloc/search_chatroom/search_chatroom_event.dart';
import '../widgets/item_message.dart';

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
          return const Center(child: CircularProgressIndicator());
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
                    margin:
                        const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: const Text(
                      'Tương hợp mới',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(229, 58, 69, 100)),
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: _buildNewChatRoomsList(state.newChatRoomsStream,
                        state.currentUserId, state.user),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 20),
                    child: const Text(
                      'Tin nhắn',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(229, 58, 69, 100)),
                    ),
                  ),
                  SingleChildScrollView(
                    child: _buildChatRoomsList(
                        state.chatRoomsStream, state.currentUserId, state.user),
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

  Widget _buildChatRoomsList(
      Stream<List<ChatRoomEntity>> stream, String currentUid, UserEntity user) {
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
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = snapshot.data?[index];
                  String uid = data!.chatRoomId
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(currentUid ?? "", "");
                  String chatRoomId = data.chatRoomId!;
                  return BlocProvider<ChatItemBloc>(
                      key: ValueKey(chatRoomId),
                      create: (context) => sl()..add(GetChatItem(uid, chatRoomId)),
                      child: MyItemMessage(uid: uid, chatRoomId: chatRoomId));
                },
              )
            : Container();
      },
    );
  }

  Widget _buildNewChatRoomsList(
      Stream<List<ChatRoomEntity>> stream, String currentUid, UserEntity user) {
    return StreamBuilder<List<ChatRoomEntity>>(
      stream: stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('errr'),
          );
        }
        return snapshot.hasData
            ? snapshot.data!.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = snapshot.data?[index];
                      String uid = data!.chatRoomId
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(currentUid ?? "", "");
                      String chatRoomId = data.chatRoomId!;
                      return index == 0
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                myImage(user.avatar!, AppAssets.iconHeart3Lines,
                                    user.followersList!.length),
                                BlocProvider<ChatItemBloc>(
                                    key: ValueKey(chatRoomId),
                                    create: (context) =>
                                        sl()..add(GetChatItem(uid, chatRoomId)),
                                    child: CircleMessageItem(
                                        uid: uid, chatRoomId: chatRoomId))
                              ],
                            )
                          : BlocProvider<ChatItemBloc>(
                              key: ValueKey(chatRoomId),
                              create: (context) =>
                                  sl()..add(GetChatItem(uid, chatRoomId)),
                              child: CircleMessageItem(
                                  uid: uid, chatRoomId: chatRoomId));
                    },
                  )
                : myImage(user.avatar!, AppAssets.iconHeart3Lines,
                    user.followersList!.length)
            : myImage(user.avatar!, AppAssets.iconHeart3Lines,
                user.followersList!.length);
      },
    );
  }

  Widget myImage(String url, String icon, int likes) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 13),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(229, 238, 181, 27),
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 90,
                    height: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(url), // Đường dẫn tới ảnh
                        fit: BoxFit
                            .fill, // Cách ảnh sẽ được hiển thị trong Container
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image(image: AssetImage(icon), height: 30, width: 30),
              ),
            ],
          ),
          Text(
            likes != 0 ? '${likes} lượt thích' : '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget search(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    focusNode.unfocus();
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
              focusNode: focusNode,
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
