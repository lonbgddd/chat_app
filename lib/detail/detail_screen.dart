import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen(
      {Key? key, this.uid, this.chatRomId, this.name, this.avatar})
      : super(key: key);

  final String? uid;
  final String? chatRomId;
  final String? name;
  final String? avatar;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final messageController = TextEditingController();
  Stream<QuerySnapshot>? chats;

  addMessage() {
    print(widget.chatRomId);
    if (messageController.text.isNotEmpty) {
      print(widget.chatRomId);
      DatabaseMethods().addMessage(
          widget.chatRomId ?? "",
          ChatMessage(
              uid: widget.uid ?? "",
              messageText: messageController.text,
              imageURL: '',
              time: DateTime.now()));

      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    DatabaseMethods().getChats(widget.chatRomId ?? "").then((val) {
      setState(() {
        chats = val;
      });
    });

    super.initState();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    String? uid = widget.uid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatar.toString()),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${widget.name}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: chats,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 70),
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (snapshot.data?.docs[index]['uid'] != uid
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (snapshot.data?.docs[index]['uid'] != uid
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                snapshot.data?.docs[index]['messageText'],
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const CircularProgressIndicator();
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      await addMessage();
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
