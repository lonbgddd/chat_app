import 'dart:ui';

import 'package:chat_app/config/changedNotify/liked_user_card_provider.dart';

import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/message/presentation/bloc/detail_message/detail_message_bloc.dart';
import '../../features/message/presentation/widgets/detail_message.dart';
import '../../injection_container.dart';

class LikedUserCard extends StatelessWidget {
  const LikedUserCard({super.key, this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .goNamed('Home-detail-others', queryParameters: {'uid': user!.uid});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(children: [
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: user!.avatar.isNotEmpty
                        ? NetworkImage(user!.avatar)
                        : const NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15))),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.6, 1]),
                borderRadius: BorderRadius.circular(15)),
          ),
          FutureBuilder(
              future: context
                  .watch<LikedUserCardProvider>()
                  .checkMatched(user!.uid),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Text(
                                '${user?.fullName}, ${DateTime.now().year - int.parse(user!.birthday.substring(0, 4))}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: (user?.fullName.length ?? 0) > 10
                                      ? 13
                                      : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(15)),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(15))),
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          context.goNamed('detail-message',queryParameters: {
                                            'uid': user!.uid,
                                            'chatRoomId':snapshot.data!.chatRoomId,
                                            'name': user!.fullName,
                                            'avatar': user!.avatar,
                                            'token': user!.token
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Text(
                                '${user?.fullName}, ${DateTime.now().year - int.parse(user!.birthday.substring(0, 4))}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: (user?.fullName.length ?? 0) > 10
                                      ? 13
                                      : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(15)),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(15))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await context
                                                .read<LikedUserCardProvider>()
                                                .removeFollow(user!.uid);
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.red,
                                          )),
                                      Container(
                                        width: 1,
                                        height: 20, // Adjust height as needed
                                        color: Colors.white,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            context
                                                .read<LikedUserCardProvider>()
                                                .addFollow(user!.uid);
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.greenAccent,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
              })

          // if (snapshot.hasData) const MatchedLabel(),
          //
        ]),
      ),
    );
  }
}

class MatchedLabel extends StatelessWidget {
  const MatchedLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))]),
        child: const Center(
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

int calculateAge(String birthdayString) {
  DateTime birthday = DateTime.parse(birthdayString);
  DateTime today = DateTime.now();
  int age = today.year - birthday.year;

  if (today.month < birthday.month ||
      (today.month == birthday.month && today.day < birthday.day)) {
    age--;
  }

  return age;
}
