import 'dart:ui';

import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LikedUserCard extends StatefulWidget {
  const LikedUserCard({
    super.key,
    this.user,
    this.chatRoom,
    required this.onDislikeCallback,
  });
  final User? user;
  final ChatRoom? chatRoom;
  final VoidCallback onDislikeCallback;

  @override
  State<LikedUserCard> createState() => _LikedUserCardState();
}

class _LikedUserCardState extends State<LikedUserCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  ChatRoom? chatRoom;

  @override
  void initState() {
    super.initState();
    chatRoom = widget.chatRoom;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    if (_animationController.isAnimating) return;
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 0))
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: widget.user!.avatar.isNotEmpty
                      ? NetworkImage(widget.user!.avatar)
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
        if (chatRoom == null)
          Positioned(
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
                    "${widget.user!.fullName}, ${calculateAge(widget.user!.birthday)}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(15)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(15))),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.onDislikeCallback();
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              )),
                          Container(
                            width: 1,
                            height: 20, // Adjust height as needed
                            color: Colors.white,
                          ),
                          IconButton(
                              onPressed: () async {
                                _toggleFavorite();
                                await context
                                    .read<FollowNotify>()
                                    .addFollow(widget.user!.uid)
                                    .then((value) {
                                  DatabaseMethods()
                                      .getChatRoom(widget.user!.uid)
                                      .then((chatRoom) {
                                    setState(() {
                                      this.chatRoom = chatRoom;
                                    });
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        if (chatRoom != null) const MatchedLabel(),
        if (chatRoom != null)
          Positioned(
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
                    "${widget.user!.fullName}, ${calculateAge(widget.user!.birthday)}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(15)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(15))),
                      child: Center(
                        child: IconButton(
                            onPressed: () async {
                              await HelpersFunctions()
                                  .getUserIdUserSharedPreference()
                                  .then((uid) {
                                context
                                    .goNamed('Home-detail', queryParameters: {
                                  'uid': uid,
                                  'chatRomId': chatRoom!.chatRoomId,
                                  'name': widget.user!.fullName,
                                  'avatar': widget.user!.avatar
                                });
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
          ),
        AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: const Align(
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 60,
                  ),
                ),
              ),
            );
          },
        ),
      ]),
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
