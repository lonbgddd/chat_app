import 'package:chat_app/config/changedNotify/notification_watch.dart';
import 'package:chat_app/home/notification/wdget/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotificationWatch>().getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        primary: true,
        body: Stack(
          children: [
            const SizedBox(
              height: 40,
            ),
            FutureBuilder(
              future: context.watch<NotificationWatch>().getNotification(),
              builder: (context, snapshot) => snapshot.hasData
                  ? snapshot.connectionState == ConnectionState.done
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 90),
                          itemCount: context
                              .watch<NotificationWatch>()
                              .listNotification
                              .length,
                          itemBuilder: (context, index) {
                            return ItemNotification(
                              title: snapshot.data[index]['mess'],
                              subtitle: snapshot.data[index]['avatar'],
                              imageUrl: snapshot.data[index]['avatar'],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                  : const Center(
                      child: Text("Không có thông báo nào"),
                    ),
            ),
            Positioned(
                top: 30,
                left: 5,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    const Text(
                      'Notification',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    const SizedBox(
                      width: 30,
                    )
                  ],
                )),
          ],
        ));
  }
}
