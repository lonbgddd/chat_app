
import 'package:chat_app/features/message/domain/entities/user_entity.dart';
import 'package:chat_app/features/message/presentation/bloc/search_chatroom/search_chatroom_bloc.dart';
import 'package:chat_app/features/message/presentation/bloc/search_chatroom/search_chatroom_event.dart';
import 'package:chat_app/features/message/presentation/widgets/item_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/helpers/helpers_database.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/chat_room_entity.dart';
import '../bloc/chat_item/chat_item_bloc.dart';
import '../bloc/search_chatroom/search_chatroom_state.dart';

class SearchMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchMessageState();
  }
}

class SearchMessageState extends State<SearchMessage> {
  String? keyUid;
  FocusNode focusNode = FocusNode();
  String search = '';
  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    getUserChat();
  }
  getUserChat() async {
    keyUid = await HelpersFunctions().getUserIdUserSharedPreference() as String;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: BlocConsumer<SearchChatRoomBloc, SearchChatRoomState>(
                listener: (context, state) {
                },
                builder: (context, state) {
                  if (state is ChatRoomsLoaded) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Search(),
                          const SizedBox(
                            height: 20,
                          ),
                          chatRoomsList(state.chatRooms,state.listUsers),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                }),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget chatRoomsList(Stream<List<ChatRoomEntity>> stream,List<UserEntity> listUser) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('errr'),
          );
        }
        return snapshot.hasData
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                 // final data = snapshot.data![index];
                  if (listUser[index]
                      .fullName!
                      .toLowerCase()
                      .toString()
                      .contains(search)) {
                    for(var chatRoom in  snapshot.data!){
                      String uid = chatRoom!.chatRoomId
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(keyUid ?? "", "");
                      String chatRoomId = chatRoom.chatRoomId!;
                      if(uid == listUser[index].uid){
                        return BlocProvider<ChatItemBloc>(
                            key: ValueKey(chatRoomId),
                            create: (context) =>
                            sl()..add(GetChatItem(uid, chatRoomId)),
                            child: MyItemMessage(uid: uid, chatRoomId: chatRoomId));
                      }
                    }
                  }
                  return const SizedBox.shrink();
                },
                separatorBuilder: (context, index) => Container(),
              )
            : Container();
      },
    );
  }


  Widget Search() {
    return Row(
      children: [
        Expanded(
          child: Card(
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
                    focusNode: focusNode,
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
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
          ),
        ),
      ],
    );
  }

}
