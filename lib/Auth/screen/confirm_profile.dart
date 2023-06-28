import 'dart:io';

import 'package:chat_app/Auth/screen/pageConfirm/add_birthday_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_dating_purpose_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_gender_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_interests_list_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_name_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_photos_list_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_request_to_show_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/add_sexual_orientation_list_page.dart';
import 'package:chat_app/Auth/screen/pageConfirm/rulers_page.dart';
import 'package:chat_app/config/changedNotify/confirm_profile_watch.dart';
import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/login_google.dart';
import '../../config/helpers/app_assets.dart';
import '../../config/helpers/enum_cal.dart';

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
                          RulersPageSection(),
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
