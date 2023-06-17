import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_router/go_router.dart';
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
    Provider.of<ProfileWatch>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        body: FutureBuilder<User>(
            future: context.read<ProfileWatch>().getUser(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onTap: () {},
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0XFF247DCF), // Specify the color of the border
                                        width: 1.0,  // Specify the width of the border
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
                        ),
                        // ListView(
                        //   padding: EdgeInsets.zero,
                        //   shrinkWrap: true,
                        //   scrollDirection: Axis.vertical,
                        //   children: [
                        //     Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       children: [
                        //         Container(
                        //           width: MediaQuery.of(context).size.width,
                        //           height: 50,
                        //           decoration: const BoxDecoration(
                        //             color: Colors.white,
                        //             shape: BoxShape.rectangle,
                        //           ),
                        //           child: Row(
                        //             mainAxisSize: MainAxisSize.max,
                        //             children: [
                        //               const Padding(
                        //                 padding: EdgeInsetsDirectional.fromSTEB(
                        //                     24, 0, 0, 0),
                        //                 child: Text(
                        //                   'Update avatar',
                        //                   style: TextStyle(
                        //                     fontFamily: 'Lexend Deca',
                        //                     color: Color(0xFF090F13),
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.normal,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Expanded(
                        //                 child: Align(
                        //                   alignment: const AlignmentDirectional(
                        //                       0.9, 0),
                        //                   child: IconButton(
                        //                       onPressed: () async {
                        //                         context
                        //                             .go('/home/update-avatar');
                        //                       },
                        //                       padding: EdgeInsets.zero,
                        //                       icon: const Icon(
                        //                         Icons.arrow_forward_ios,
                        //                         color: Color(0xFF95A1AC),
                        //                         size: 18,
                        //                       )),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsetsDirectional.fromSTEB(
                        //           0, 1, 0, 0),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.max,
                        //         children: [
                        //           Container(
                        //             width: MediaQuery.of(context).size.width,
                        //             height: 50,
                        //             decoration: const BoxDecoration(
                        //               color: Colors.white,
                        //               shape: BoxShape.rectangle,
                        //             ),
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.max,
                        //               children: const [
                        //                 Padding(
                        //                   padding:
                        //                       EdgeInsetsDirectional.fromSTEB(
                        //                           24, 0, 0, 0),
                        //                   child: Text(
                        //                     'Notifications',
                        //                     style: TextStyle(
                        //                       fontFamily: 'Lexend Deca',
                        //                       color: Color(0xFF090F13),
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.normal,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Expanded(
                        //                   child: Align(
                        //                     alignment:
                        //                         AlignmentDirectional(0.9, 0),
                        //                     child: Icon(
                        //                       Icons.arrow_forward_ios,
                        //                       color: Color(0xFF95A1AC),
                        //                       size: 18,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsetsDirectional.fromSTEB(
                        //           0, 1, 0, 0),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.max,
                        //         children: [
                        //           Container(
                        //             width: MediaQuery.of(context).size.width,
                        //             height: 50,
                        //             decoration: const BoxDecoration(
                        //               color: Colors.white,
                        //               shape: BoxShape.rectangle,
                        //             ),
                        //             child: Row(
                        //               mainAxisSize: MainAxisSize.max,
                        //               children: const [
                        //                 Padding(
                        //                   padding:
                        //                       EdgeInsetsDirectional.fromSTEB(
                        //                           24, 0, 0, 0),
                        //                   child: Text(
                        //                     'Change Password',
                        //                     style: TextStyle(
                        //                       fontFamily: 'Lexend Deca',
                        //                       color: Color(0xFF090F13),
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.normal,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Expanded(
                        //                   child: Align(
                        //                     alignment:
                        //                         AlignmentDirectional(0.9, 0),
                        //                     child: Icon(
                        //                       Icons.arrow_forward_ios,
                        //                       color: Color(0xFF95A1AC),
                        //                       size: 18,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  context.read<CallDataProvider>().signOut();
                                  GoRouter.of(context)
                                      .pushReplacement('/login-home-screen');
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
                                    color: Color(0xFF4B39EF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container();
            }));
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.avataUrl,
  });

  final String avataUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(avataUrl), fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Center(
                  child: Icon(
                Icons.edit,
                color: Color(0XFFAA3FEC),
                size: 16,
              )),
            ),
          )
        ],
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
