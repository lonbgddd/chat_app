import 'package:chat_app/config/changedNotify/search_message.dart';

import 'package:chat_app/features/message/presentation/widgets/item_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../config/changedNotify/home_watch.dart';
import '../../../../config/helpers/helpers_database.dart';
import '../../../../injection_container.dart';
import '../../../../model/user_model.dart';
import '../bloc/chat_item/chat_item_bloc.dart';

class SearchMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchMessageState();
  }
}

class SearchMessageState extends State<SearchMessage> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRooms;
  String? keyUid;
  FocusNode focusNode = FocusNode();
  List<UserModel> listUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.requestFocus();
    getUserChat();

  }

  getUserChat() async {
    keyUid = await HelpersFunctions().getUserIdUserSharedPreference() as String;
    await Provider.of<SearchMessageProvider>(context, listen: false).getUserChats()?.then(
      (value) async {
        setState(() {
          chatRooms = value;
        });
      },
    );
    await context.read<SearchMessageProvider>().getListUserChat(keyUid!).then((value) {
        setState(() {
          listUser = value;
        });
    });
  }



  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatRooms,
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data?.docs[index];
                  String uid = data!['chatRoomId']
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(keyUid ?? "", "");
                  String chatRoomId = data['chatRoomId'];
                  if(listUser[index].fullName.toLowerCase().toString().contains(context.watch<SearchMessageProvider>().name)) {
                      return BlocProvider<ChatItemBloc>(
                          key: ValueKey(chatRoomId),
                          create: (context) =>
                          sl()..add(GetChatItem(uid, chatRoomId)),
                          child: MyItemMessage(uid: uid, chatRoomId: chatRoomId));
                  }
                  return const SizedBox.shrink();
                },
                separatorBuilder: (context, index) => Container(),
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Search(),
                const SizedBox(
                  height: 20,
                ),
                listUser.isNotEmpty ? chatRoomsList(): Container()
              ],
            ),
          )),
        ),
      ),
      debugShowCheckedModeBanner: false,
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
                      context.read<SearchMessageProvider>().search(value);
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