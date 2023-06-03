import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/model/model.dart';
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
    // TODO: implement initState
    super.initState();
    context.read<FollowNotify>().userFollowYou();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: context.watch<FollowNotify>().userFollowYou(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('See who like you',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Colors.blueAccent,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                    GridView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 20,
                              mainAxisExtent: 250),
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data![index].avatar,
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Text(
                                  snapshot.data![index].name +
                                      "\n" +
                                      snapshot.data![index].sex,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    backgroundColor: Colors.white54,
                                  ),
                                )),
                          ),
                        );
                      },
                    )
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
