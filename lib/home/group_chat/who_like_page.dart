import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/home/group_chat/liked_user_card.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WhoLikePage extends StatefulWidget {
  const WhoLikePage({Key? key}) : super(key: key);

  @override
  State<WhoLikePage> createState() => _WhoLikePageState();
}

class _WhoLikePageState extends State<WhoLikePage> {
  @override
  void initState() {
    // context.read<FollowNotify>().userFollowYou();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Likes',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "This is a list of people who have liked you and your matches.",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7), fontSize: 16),
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.7),
                indent: 20,
                endIndent: 20,
              ),
              FutureBuilder(
                  future: context.watch<FollowNotify>().userFollowYou(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      return snapshot.hasData
                          ? GridView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              addAutomaticKeepAlives: false,
                              physics: const ScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) {
                                UserModel user = snapshot.data![index];
                                return LikedUserCard(
                                  user: user,
                                );
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
