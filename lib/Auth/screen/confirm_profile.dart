import 'package:chat_app/Auth/screen/pageConfirm/add_birthday_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_dating_purpose_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_gender_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_interests_list_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_name_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_photos_list_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_request_to_show_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_sexual_orientation_list_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/rules_page.dart';
import 'package:chat_app/config/changedNotify/confirm_profile_watch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class ConfirmProfile extends StatelessWidget {
  const ConfirmProfile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);
   return WillPopScope(
        onWillPop: () async {
          if (pageProvider.currentPageIndex > 0) {
            pageProvider.previousPage();
            return false;
          } else {
            pageProvider.showCustomDialog(context);
            return true;
          }
        },
        child: Scaffold(
          body:  Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(234, 64, 128, 1)),
                        backgroundColor: Colors.grey.shade200,
                        value: (pageProvider.currentPageIndex + 1) / 9,
                      ),
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: pageProvider.currentPageIndex,
                        children: [
                          RulesPageSection(),
                          AddNamePageSection(),
                          AddBirthdayPageSection(),
                          AddGenderPageSection(),
                          AddRequestToShowPageSection(),
                          AddSexualOrientationListPageSection(),
                          AddDatingPurposePageSection(),
                          AddInterestsListPageSection(),
                          AddPhotoListPageSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

        ),
      );

    }

}
