import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/model.dart';

class SearchUserChat extends StatefulWidget {
  const SearchUserChat({Key? key}) : super(key: key);

  @override
  State<SearchUserChat> createState() => _SearchUserChatState();
}

class _SearchUserChatState extends State<SearchUserChat> {
  TextEditingController searchEditingController = TextEditingController();
  final DatabaseMethods _methods = DatabaseMethods();
  List<User> list = [];

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await _methods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        list = snapshot;
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
        return list;
      });
      print("$list");
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return userTile(list[index].name ?? "", list[index].email ?? "",
                  list[index].uid ?? "");
            })
        : Container();
  }

  sendMessage(String uid) async {
    List<String> users = [
      (await HelpersFunctions().getUserIdUserSharedPreference()) as String,
      uid
    ];

    String chatRoomId = getChatRoomId(
        (await HelpersFunctions().getUserIdUserSharedPreference()) as String,
        uid);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    _methods.addChatRoom(chatRoom, chatRoomId);

    // Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => Chat(
    //       chatRoomId: chatRoomId,
    //     )
    // ));
  }

  Widget userTile(String userName, String userEmail, String uid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          const CircleAvatar(backgroundImage: NetworkImage('url')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                userEmail,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(uid);
              context.go('/home/search-user/detail', extra: uid);
              // context.goNamed('/home/search-user/detail', extra: uid);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: const Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () => context.pop(),
                            padding: EdgeInsets.zero,
                            icon:
                                const Icon(Icons.arrow_back_ios_new_outlined)),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextField(
                            controller: searchEditingController,
                            decoration: const InputDecoration(
                                hintText: "search username ...",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            initiateSearch();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight),
                                borderRadius: BorderRadius.circular(40)),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(Icons.search),
                          )),
                    ],
                  ),
                ),
                userList()
              ],
            ),
    );
  }
}
