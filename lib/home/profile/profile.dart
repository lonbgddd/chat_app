import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:chat_app/home/profile/components/profile_avatar.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<ProfileWatch>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF1F4F8),
          body: StreamBuilder<User>(
              stream: context.watch<ProfileWatch>().getUserStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String dateString = snapshot.data!.birthday;
                  DateTime dateTime = DateTime.parse(dateString);
                  String formattedDate = DateFormat.yMMMMd().format(dateTime);
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            color: const Color(0XFFAA3FEC).withOpacity(0.8),
                            child: GestureDetector(
                              onTap: () {
                                context.go('/home/update-avatar');
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ProfileAvatar(
                                      avataUrl: snapshot.data!.avatar,
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      "${snapshot.data!.fullName}, ${calculateAge(snapshot.data!.birthday)}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Account Settings',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.goNamed("update-profile",
                                          queryParameters: {
                                            'uid': snapshot.data!.uid
                                          });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(
                                                0XFF247DCF), // Specify the color of the border
                                            width:
                                                1.0, // Specify the width of the border
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0XFF247DCF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InforRow(
                                title: "Name",
                                content: snapshot.data!.fullName,
                              ),
                              InforRow(
                                title: "Email",
                                content: snapshot.data!.email,
                              ),
                              InforRow(
                                title: "Gender",
                                content: snapshot.data!.gender,
                              ),
                              InforRow(
                                title: "Birthday",
                                content: formattedDate,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 16.0),
                                padding: const EdgeInsets.all(16.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0XFFC6C6C6))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Biography",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        snapshot.data!.biography,
                                        style: const TextStyle(
                                            color: Color(0XFF8E8E8E),
                                            fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 16.0),
                                padding: const EdgeInsets.all(16.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0XFFC6C6C6))),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Interests",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Wrap(
                                        children: List.generate(
                                            snapshot.data!.interests.length,
                                            (index) => InterestItem(
                                                title: snapshot
                                                    .data!.interests[index])),
                                      )
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        context
                                            .read<CallDataProvider>()
                                            .signOut();
                                        GoRouter.of(context).pushReplacement(
                                            '/login-home-screen');
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.white),
                                          foregroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.green)),
                                      child: const Text(
                                        'Sign Out',
                                        style: TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              })),
    );
  }
}

class InterestItem extends StatelessWidget {
  const InterestItem({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0XFFAA3FEC).withOpacity(0.4),
            const Color(0XFFAA3FEC).withOpacity(0.8)
          ]),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}

class InforRow extends StatelessWidget {
  const InforRow({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1.0, color: const Color(0XFFC6C6C6))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          content,
          style: const TextStyle(color: Color(0XFF8E8E8E), fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ]),
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
