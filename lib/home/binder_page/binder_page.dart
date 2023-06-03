import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';

class BinderPage extends StatefulWidget {
  const BinderPage({Key? key}) : super(key: key);

  @override
  State<BinderPage> createState() => _BinderPageState();
}

class _BinderPageState extends State<BinderPage> {
  CardController? controller;
  bool isDisLike = false;
  bool isLike = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BinderWatch>().allUserBinder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 20),
      child: SizedBox(
        height: size.height,
        child: FutureBuilder(
          future: context.watch<BinderWatch>().allUserBinder(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            return snapshot.hasData
                ? TinderSwapCard(
                    totalNum: snapshot.data?.length,
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                    minWidth: MediaQuery.of(context).size.width * 0.75,
                    minHeight: MediaQuery.of(context).size.height * 0.6,
                    cardBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 2),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Container(
                              width: size.width,
                              height: size.height,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data![index].avatar ?? ''),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            isDisLike
                                ? const Positioned(
                                    child: Center(
                                        child: Icon(
                                    Icons.dangerous_outlined,
                                    color: Colors.red,
                                    size: 130,
                                  )))
                                : Container(),
                            isLike
                                ? const Positioned(
                                    child: Center(
                                        child: Icon(
                                    Icons.favorite_outlined,
                                    color: Colors.red,
                                    size: 130,
                                  )))
                                : Container(),
                            Container(
                              width: size.width,
                              height: size.height,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    Colors.black.withOpacity(0.25),
                                    Colors.black.withOpacity(0),
                                  ],
                                      end: Alignment.topCenter,
                                      begin: Alignment.bottomCenter)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.72,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data![index]
                                                            .name ??
                                                        '',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${DateTime.now().year - DateTime.parse(snapshot.data![index].year).year} tuổi',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.green,
                                                            shape: BoxShape
                                                                .circle),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    "Recently Active",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: List.generate(2,
                                                    (indexLikes) {
                                                  if (indexLikes == 0) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color:
                                                                Colors.white),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3,
                                                                  bottom: 3,
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Text(
                                                            snapshot
                                                                    .data![
                                                                        index]
                                                                    .sex ??
                                                                '',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.white),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3,
                                                                bottom: 3,
                                                                left: 10,
                                                                right: 10),
                                                        child: Text(
                                                          "Chào",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: size.width * 0.2,
                                            child: const Center(
                                              child: Icon(
                                                Icons.info,
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    cardController: controller = CardController(),
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      /// Get swiping card's alignment
                      double check = details.delta.dx;
                      if (check < 0) {
                        setState(() => isDisLike = true);
                        setState(() => isLike = false);
                      } else if (check == 0) {
                        setState(() => isDisLike = false);
                        setState(() => isLike = false);
                      } else if (check > 0) {
                        setState(() => isDisLike = false);
                        setState(() => isLike = true);
                      }
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      /// Get orientation & index of swiped card!
                      orientation.name == "RIGHT"
                          ? context
                              .read<BinderWatch>()
                              .addFollow(snapshot.data![index].uid)
                          : null;
                      setState(() => isDisLike = false);
                      setState(() => isLike = false);
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
