import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/binder_page/compnents/item_card.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      body: getBodyP2(),
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
            final provider = Provider.of<BinderWatch>(context).listCard;
            return snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                        alignment: Alignment.center,
                        children: provider.reversed
                            .map((e) => ProfileCard(
                                  user: e,
                                  isFont: provider.first == e,
                                ))
                            .toList()),
                  )
                : const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
          },
        ),
      ),
    );
  }

  Widget getBodyP2() {
    final provider = Provider.of<BinderWatch>(context).listCard;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
          alignment: Alignment.center,
          children: provider.reversed
              .map((e) => ProfileCard(
                    user: e,
                    isFont: provider.first == e,
                  ))
              .toList()),
    );
  }
}
