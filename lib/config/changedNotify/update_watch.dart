import 'dart:io';

import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:flutter/cupertino.dart';

class UpdateNotify extends ChangeNotifier {
  Future updateImageAvatar(File? image) async {
    String uid =
        await HelpersFunctions().getUserIdUserSharedPreference() as String;
    String url = await DatabaseMethods().pushImage(image, uid);
    await DatabaseMethods().updateAvatar(url, uid);
    await HelpersFunctions.saveAvatarUserSharedPreference(url);
  }
}
