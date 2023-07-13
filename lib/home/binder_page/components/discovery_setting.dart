import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/home/binder_page/components/body_discovery_setting.dart';
import 'package:chat_app/home/binder_page/components/body_high_search.dart';
import 'package:chat_app/home/binder_page/components/range_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'body_discovery_setting.dart';

class DiscoverySetting extends StatelessWidget {
  const DiscoverySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BinderWatch>();
    final appLocal = AppLocalizations.of(context);
    return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.4,
            title: Center(
              child: Text(
                appLocal.settingPageSearchText,
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await provider.updateRequestToShow();
                  context.pop("refresh");
                },
                child: Text(
                  appLocal.discoverySettingConfirmText,
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom:20),
            child: Column(
              children: [
                BodyDiscoverySetting(isGlobal: false),
                SizedBox(height: 25,),
                BodyHighSearch()
              ],
            ),
          ),

    );
  }
}
