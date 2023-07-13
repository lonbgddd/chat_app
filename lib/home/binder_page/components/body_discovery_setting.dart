import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/binder_page/components/body_high_search.dart';
import 'package:chat_app/home/binder_page/components/range_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyDiscoverySetting extends StatelessWidget {
  final bool isGlobal;

  const BodyDiscoverySetting({super.key, required this.isGlobal});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BinderWatch>();
    final appLocal = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderContainer(
                isAgePreference: false,
                title: appLocal.discoverySettingPriorityText,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () => context.go('/home/show-me'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocal.discoverySettingShowMeText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            provider.selectedOption ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
              ),
              SliderContainer(
                isAgePreference: true,
                title:  appLocal.discoverySettingAgeText,
              ),

              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
