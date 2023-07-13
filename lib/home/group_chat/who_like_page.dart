import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/group_chat/liked_user_card.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final appLocal = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.iconTinder,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(223, 54, 64, 100), BlendMode.srcIn),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Finder",
                style: TextStyle(
                  fontFamily: 'Grandista',
                  fontSize: 24,
                  color: Color.fromRGBO(223, 54, 64, 100),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                appLocal.whoLikePageContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
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
                            padding: const EdgeInsets.all( 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 260),
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
    );
  }
}
