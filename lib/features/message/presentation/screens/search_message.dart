
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: Color.fromRGBO(234, 64, 128, 1),
          ),
          Expanded(
            child: TextField(
             onChanged: (value){
               search = value;
             },
              focusNode: focusNode,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 20),
              cursorColor: Color.fromRGBO(234, 64, 128, 1,),
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                constraints: BoxConstraints(
                  maxHeight: 40,
                ),
                hintText: AppLocalizations.of(context).messageScreenSearchText,
                hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(
                      230, 144, 174, 1.0),width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:Color.fromRGBO(234, 64, 128, 1),width: 2),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

}
