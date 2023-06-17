import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/binder_page/compnents/item_card.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BinderPage extends StatefulWidget {
  const BinderPage({Key? key}) : super(key: key);

  @override
  State<BinderPage> createState() => _BinderPageState();
}

class _BinderPageState extends State<BinderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BinderWatch>(context, listen: false).allUserBinder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<BinderWatch>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: const Text(
          "Binder",
          style: TextStyle(
              fontFamily: 'Grandista', fontSize: 24, color: Colors.purple),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.grey,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.tune,
                color: Colors.grey,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    final provider = Provider.of<BinderWatch>(context).listCard;
    print(provider);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
          alignment: Alignment.center,
          children: provider.reversed
              .map((e) => ProfileCard(
            user: e,
            isDetail:()=> context.goNamed('Home-detail-others',queryParameters: { 'uid': e.uid.toString(),}),
            isFont: provider.first == e,
          ))
              .toList()),
    );
  }
}
