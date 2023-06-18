import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/chat_item_notify.dart';
import '../../config/changedNotify/home_watch.dart';
import '../../config/helpers/helpers_database.dart';
import '../../model/model.dart';
import 'detail_message.dart';
import 'itemMessage.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessageScreenState();
  }
}

class MessageScreenState extends State<MessageScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRooms;
  String? keyUid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserChat();
    Provider.of<HomeNotify>(context, listen: false);
  }

  getUserChat() async {
    keyUid = await HelpersFunctions().getUserIdUserSharedPreference() as String;

    await context.read<HomeNotify>().getUserChats()?.then(
      (value) {
        setState(() {
          chatRooms = value;
        });
      },
    );
  }

  Widget chatRoomsList(String direction) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatRooms,
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
                itemCount: snapshot.data?.docs.length,
                physics: direction == 'vertical'
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = snapshot.data?.docs[index];
                  // return ChatRoomsTile(
                  //     uid: data!['chatRoomId']
                  //         .toString()
                  //         .replaceAll("_", "")
                  //         .replaceAll(keyUid ?? "", ""),
                  //     chatRoomId: data['chatRoomId']);
                  String uid = data!['chatRoomId']
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(keyUid ?? "", "");
                  String chatRoomId = data['chatRoomId'];
                  return direction == 'vertical'
                      ? ItemMessage(uid: uid, chatRoomId: chatRoomId)
                      : itemActivities(uid, chatRoomId);
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
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
                            border: Border.all(width: 1, color: Colors.grey),
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
              Search(),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  'Activities',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 120,
                child: chatRoomsList('horizontal'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20),
                child: const Text(
                  'Messages',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(child: chatRoomsList('vertical'))
            ],
          ),
        ),
      ),
    );
  }
  // Widget itemMessage(){
  //    return  Scaffold(
  //       body:  SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 margin: const EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 15),
  //                 child: Row(
  //                   children: [
  //                     const Text(
  //                       "Messages",
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 30,
  //                       ),
  //                     ),
  //                   const Spacer(),
  //                   Container(
  //                       decoration: BoxDecoration(
  //                           border: Border.all(width: 1, color: Colors.grey),
  //                           borderRadius: BorderRadius.circular(10)),
  //                       child: IconButton(
  //                         iconSize: 30,
  //                         padding: const EdgeInsets.all(5),
  //                         onPressed: () async {
  //                           context.go('/home/search-user');
  //                         },
  //                         icon: const Icon(
  //                           Icons.menu,
  //                           color: Colors.pink,
  //                         ),
  //                       ))
  //                 ],
  //               ),
  //             ),
  //             Search(),
  //             Container(
  //               margin: const EdgeInsets.all(20),
  //               child: const Text(
  //                 'Activities',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 120,
  //               child: chatRoomsList('horizontal'),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.only(left: 20),
  //               child: const Text(
  //                 'Messages',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //               chatRoomsList('vertical')
  //             ],
  //           ),
  //       ),
  //   );
  // }

  Widget Search() {
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
              onTap: (){
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

  Widget itemActivities(String uid, String chatRoomId) {
    // ChatMessage? mess;
    // lassMess(context) async {
    //   mess =
    //   await Provider.of<ItemChatNotify>(context).getLastMessage(chatRoomId ?? '');
    // }
    Future<User?> getUser(context) async {
      //lassMess(context);
      User user = await Provider.of<ItemChatNotify>(context)
          .getUserInformation(uid, chatRoomId ?? "");
      return user;
    }

    return FutureBuilder(
        future: getUser(context),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: DetailMessage(
                          uid: uid,
                          chatRoomId: chatRoomId.toString(),
                          name: snapshot.data?.fullName,
                          avatar: snapshot.data?.avatar,
                          token: snapshot.data?.token,
                        ));
                  });
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
                      backgroundImage:
                          NetworkImage(snapshot.data?.avatar ?? ""),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        snapshot.data?.fullName ?? "",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ),
          );
        });
  }
}
