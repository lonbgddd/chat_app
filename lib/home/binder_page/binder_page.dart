import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/home/binder_page/compnents/show_list.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BinderPage extends StatefulWidget {
  const BinderPage({Key? key}) : super(key: key);

  @override
  State<BinderPage> createState() => _BinderPageState();
}

class _BinderPageState extends State<BinderPage> {
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

  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);

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
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ValueListenableBuilder(
                          valueListenable: swipeNotifier,
                          builder: (context, swipe, _) => Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children:
                                List.generate(snapshot.data!.length, (index) {
                              return DragWidget(
                                user: snapshot.data![index],
                                index: index,
                                swipeNotifier: swipeNotifier,
                              );
                            }),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: DragTarget<int>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return IgnorePointer(
                              child: Container(
                                height: 700.0,
                                width: 80.0,
                                color: Colors.transparent,
                              ),
                            );
                          },
                          onAccept: (int index) {
                            setState(() {
                              snapshot.data!.removeAt(index);
                            });
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: DragTarget<int>(
                          builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return IgnorePointer(
                              child: Container(
                                height: 700.0,
                                width: 80.0,
                                color: Colors.transparent,
                              ),
                            );
                          },
                          onAccept: (int index) {
                            setState(() {
                              snapshot.data!.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
