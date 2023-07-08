import 'dart:convert';
import 'dart:io';

import 'package:chat_app/config/data.dart';
import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateNotify extends ChangeNotifier {
  bool isLoading = false;
  bool isInterestSearching = false;
  List<String> filteredInterestsList = HelpersUserAndValidators.interestsList;
  bool userLoaded = false;
  List<String> allLanguageList = [];
  List<String> filteredLanguageList = [];

  String gender = "";
  String datingPurpose = "";

  List<String>? photoList = [];
  List<String>? interestsList = [];
  List<String>? fluentLanguageList = [];
  List<String>? sexualOrientationList = [];

  //BasicInfoUser
  String zodiac = "";
  String academicLever = "";
  String communicateStyle = "";
  String languageOfLove = "";
  String familyStyle = "";
  String personalityType = "";

  //StyleOfLifeUser
  String myPet = "";
  String drinkingStatus = "";
  String smokingStatus = "";
  String sportsStatus = "";
  String eatingStatus = "";
  String socialNetworkStatus = "";
  String sleepingHabits = "";

  String? uid = "";

  final TextEditingController introduceYourselfController =
      TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController currentAddressController =
      TextEditingController();

  final TextEditingController searchInterestController =
  TextEditingController();

  final TextEditingController searchLanguageController =
  TextEditingController();
  Future<void> getUser(bool initTextController) async {
    userLoaded = true;
    uid = await HelpersFunctions().getUserIdUserSharedPreference();
    UserModel user = await DatabaseServices(uid).getUserInfo();
    gender = user.gender;
    datingPurpose = user.datingPurpose;
    photoList = user.photoList;
    interestsList = user.interestsList;
    fluentLanguageList = user.fluentLanguageList;
    sexualOrientationList = user.sexualOrientationList;

    //BasicInfoUser
    zodiac = user.zodiac!;
    academicLever = user.academicLever!;
    communicateStyle = user.communicateStyle!;
    languageOfLove = user.languageOfLove!;
    familyStyle = user.familyStyle!;
    personalityType = user.personalityType!;

    //StyleOfLifeUser
    myPet = user.myPet!;
    drinkingStatus = user.drinkingStatus!;
    smokingStatus = user.smokingStatus!;
    sportsStatus = user.sportsStatus!;
    eatingStatus = user.eatingStatus!;
    socialNetworkStatus = user.socialNetworkStatus!;
    sleepingHabits = user.sleepingHabits!;
    if (initTextController) {
      introduceYourselfController.text = user.introduceYourself!;
      companyController.text = user.company!;
      schoolController.text = user.school!;
      currentAddressController.text = user.currentAddress!;
    }
    isLoading = false;
    isInterestSearching = false;
    await fetchLanguages();
    notifyListeners();
  }

  Future<void> pickImages() async {
    List<XFile>? resultList = await ImagePicker().pickMultiImage();
    List<File> selectedImages =
        resultList.map((xFile) => File(xFile.path)).toList();
    if (photoList!.length + selectedImages.length <= 9) {
      for (var imageFile in selectedImages) {
        await _cropImage(imageFile: imageFile);
      }
      notifyListeners();
    } else {
      // Xử lý khi vượt quá số lượng ảnh tối đa
    }
  }

  Future<void> _cropImage({required File imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      compressQuality: 100,
      maxWidth: 500,
      maxHeight: 500,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cắt ảnh',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          statusBarColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
        IOSUiSettings(
          title: 'Cắt ảnh',
        ),
      ],
    );

    if (croppedFile != null) {
      File? croppedImage = File(croppedFile.path);
      if (croppedImage.existsSync()) {
        String fileUrl = await DatabaseMethods().pushImage(croppedImage, uid!);
        photoList!.add(fileUrl);
        notifyListeners();
        updatePhotoList();
      }
    }
  }

  void updatePhotoList() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"photoList": photoList});
  }

  Future<void> removeImage(String imageUrl) async {
    photoList!.remove(imageUrl);
    notifyListeners();
    updatePhotoList();
    await DatabaseMethods().deleteImage(imageUrl);
  }

  void searchInterest(String keyword) {
    filteredInterestsList = HelpersUserAndValidators.interestsList
        .where((item) => item.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }


  Future<void> updateInterestsList() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"interestsList": interestsList});
  }

  Future<void> updateDatingPurpose() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"datingPurpose": datingPurpose});
  }

  Future<void> updateBasicInformation() async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "zodiac": zodiac,
      "academicLever": academicLever,
      "familyStyle": familyStyle,
      "personalityType": personalityType,
      "communicateStyle": communicateStyle,
      "languageOfLove": languageOfLove
    });
  }

  Future<void> updateLifeStyle() async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "myPet": myPet,
      "drinkingStatus": drinkingStatus,
      "smokingStatus": smokingStatus,
      "sportsStatus": sportsStatus,
      "eatingStatus": eatingStatus,
      "socialNetworkStatus": socialNetworkStatus,
      "sleepingHabits": sleepingHabits
    });
  }

  Future<void> updateInputField() async {
    userLoaded = false;
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "introduceYourself": introduceYourselfController.text,
      "company": companyController.text,
      "school": schoolController.text,
      "currentAddress": currentAddressController.text,
    });
    notifyListeners();
  }

  Future<void> updateGender() async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "gender": gender,
    });
  }

  Future<void> updateSexualOrientationList() async {
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "sexualOrientationList": sexualOrientationList,
    });
  }

  void loading() {
    isLoading = true;
    onDataChange();
  }

  void stopLoading() {
    isLoading = false;
    onDataChange();
  }

  void onDataChange() {
    notifyListeners();
  }

  Future<void> fetchLanguages() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      List<String> languages = [];
      for (var item in data) {
        final languageName = item['name']['common'] as String;

        languages.add(languageName);
      }
      languages.sort((a, b) => a.compareTo(b));
      allLanguageList = languages;
      filteredLanguageList = languages;
      notifyListeners();
    } else {
      throw Exception('Failed to fetch languages');
    }
  }

  void searchLanguage(String keyword) {
    filteredLanguageList = allLanguageList
        .where((item) => item.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> updateFluentLanguageList() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"fluentLanguageList": fluentLanguageList});
  }
}
