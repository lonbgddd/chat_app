import 'package:chat_app/config/changedNotify/notification_watch.dart';
import 'package:chat_app/home/notification/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context).notificationScreenTitle,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.red,)),
      ),
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
                  ? snapshot.connectionState == ConnectionState.waiting
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 90),
                          itemCount: context
                              .watch<NotificationWatch>()
                              .listNotification
                              .length,
                          itemBuilder: (context, index) {
                            return ItemNotification(
                              title: snapshot.data[index]['type'],
                              mess: snapshot.data[index]['mess'],
                              imageUrl: snapshot.data[index]['avatar'],
                              idUser: snapshot.data[index]['uid'],
                              status: snapshot.data[index]['status'],
                              time: snapshot.data[index]['time'],
                              chatRoomId: snapshot.data[index]['chatRoomId'],
                              name: snapshot.data[index]['name'],
                            );
                          },
                        )
                      :  Center(
                          child: CircularProgressIndicator(),
                        )
                  : Center(
                    child: CircularProgressIndicator(),
                 ),
            ),

          ],
        ));
  }
}
