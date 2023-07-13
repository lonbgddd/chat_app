import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/setting/components/body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BinderWatch>();
    final padding =  MediaQuery.of(context).padding;
    return  Container(
      color:  Colors.white,
      padding: EdgeInsets.only(top: 30),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.3,
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                AppLocalizations.of(context).settingPageSubTitleAppBar,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          actions: [
            TextButton(
                onPressed:() async{
                  await provider.updateRequestToShow();
                  context.pop();} ,
                child: Text(
                  AppLocalizations.of(context).settingPageSubDoneText,
                  style: TextStyle(color: Colors.blueAccent),
                ))
          ],
          automaticallyImplyLeading: false,
          leading: Text(""),
        ),
        backgroundColor: Colors.grey[200],
        body: Body()

      ),
    );
  }
}
