import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/home/item_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/changedNotify/home_watch.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data?.docs[index];
                  return ChatRoomsTile(
                      uid: data!['chatRoomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(keyUid ?? "", ""),
                      chatRoomId: data['chatRoomId']);
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: GestureDetector(
                        onTap: () => context.go('/home/search-user'),
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.pink,
                              size: 20,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Add New",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // search
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            chatRoomsList()
          ],
        ),
      ),
    );
  }
}
