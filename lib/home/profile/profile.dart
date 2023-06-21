import 'dart:io';

import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/home/profile/components/infor_row.dart';
import 'package:chat_app/home/profile/components/interest_item.dart';
import 'package:chat_app/home/profile/components/profile_avatar.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final imagePick = ImagePicker();
  File? imageGallery;

  getImageGallery() async {
    await imagePick.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          imageGallery = File(image.path);
        });
        Provider.of<UpdateNotify>(context, listen: false)
            .updateImageAvatar(imageGallery);
      }
    });

  }

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
          body: StreamBuilder<UserModal>(
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
                            color: const Color.fromRGBO(229, 58, 69, 100),
                            child: GestureDetector(
                              onTap: () {
                                getImageGallery();
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ProfileAvatar(
                                      avatarUrl: snapshot.data!.avatar,
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
                                        snapshot.data!.introduceYourself,
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
                                            snapshot.data!.interestsList.length,
                                            (index) => InterestItem(
                                                title: snapshot
                                                    .data!.interestsList[index])),
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
