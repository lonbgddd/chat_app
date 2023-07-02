import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../data_mothes.dart';
import '../helpers/app_assets.dart';
import 'login_google.dart';


enum PageNavigationDirection { Forward, Backward }

class PageDataConfirmProfileProvider extends ChangeNotifier {
  int currentPageIndex = 0;

  final nameController = TextEditingController();
  bool isTextFieldNameEmpty = true;


  final  dayController = TextEditingController();
  final  monthController = TextEditingController();
  final  yearController = TextEditingController();
  final  dayFocusNode = FocusNode();
  final  monthFocusNode = FocusNode();
  final  yearFocusNode = FocusNode();

  String birthday = '';
  bool isErrorBirthday = false;
  bool isBirthdayEmpty = true;

  String selectedGender = '';
  bool isGenderEmpty = true;

  String selectedRequestToShow = '';
  bool isRequestToShowEmpty = true;

  List<String> newSexualOrientationList = [];
  bool isSexualOrientationEmpty = true;

  String newDatingPurpose ='';
  int selectedIndexDatingPurpose = -1;

  List<String> newInterestsList = [];
  bool isInterestsEmpty = true;

  List<File> photosList = [];
  int imageCount = 0;
  bool isEditingPhoto = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }



  void onTextFieldNameChanged() {
    isTextFieldNameEmpty = nameController.text.isEmpty;
    notifyListeners();
  }


  void onBirthdayChange(String value) {
      birthday = '${yearController.text}-${monthController.text}-${dayController.text}';
      isBirthdayEmpty = birthday.length < 10;
      notifyListeners();
  }


  void onGenderChanged() {
      isGenderEmpty = selectedGender.isEmpty;
      notifyListeners();
  }

  void onRequestChanged() {
      isRequestToShowEmpty = selectedRequestToShow.isEmpty;
      notifyListeners();
  }

  void onSexualOrientationListChanged() {
    isSexualOrientationEmpty = newSexualOrientationList.length < 3;
    notifyListeners();
  }

  void onDatingPurposeChanged(String value, int index) {
    selectedIndexDatingPurpose = index;
    newDatingPurpose = value;
    notifyListeners();
  }
  void onInterestsListChanged() {
    isInterestsEmpty = newInterestsList.length < 5;
    notifyListeners();
  }


  void nextPage() {
    if (currentPageIndex < 9) {
      currentPageIndex++;
      notifyListeners();
    }
  }
  void onPageChanged(int page ) {
    currentPageIndex = page;
    notifyListeners();
  }

  void previousPage() {
    if (currentPageIndex > 0) {
      currentPageIndex--;
      notifyListeners();
    }
  }

  void removeImageFromList(int index) {
      photosList.removeAt(index);
      imageCount = photosList.length;
      if (photosList.length == 1) {
        isEditingPhoto = false;
      }
      notifyListeners();
  }


  Future<void> pickImages() async {
    List<XFile>? resultList = await ImagePicker().pickMultiImage();
    if (resultList != null) {
      List<File> selectedImages = resultList.map((xFile) => File(xFile.path)).toList();
      if (photosList.length + selectedImages.length <= 6) {
        for(var imageFile in selectedImages){
          await _cropImage(imageFile: imageFile);
        }
          imageCount = photosList.length;
          isEditingPhoto = photosList.length > 1;
          notifyListeners();
      } else {
        // Xử lý khi vượt quá số lượng ảnh tối đa
      }
    }

  }

  Future<File?> _cropImage({required File imageFile}) async {
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
          photosList.add(croppedImage);
          notifyListeners();
      }
    }
  }


  Future<void> confirmUser(BuildContext context) async {
    isLoading = true;
    print('Số lượng ảnh: ${photosList.length}');
    final signUp = context.read<CallDataProvider>();
    List<String> urlImages = [];
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      urlImages = await DatabaseMethods().pushListImage(photosList, user.uid);
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await signUp.confirmProfile(nameController.text, selectedGender, selectedRequestToShow, birthday,  newInterestsList, newDatingPurpose, urlImages, newSexualOrientationList,   [position.longitude.toString(), position.latitude.toString()]).whenComplete(() =>  isLoading = false);
    context.go('/home');

  }


  showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.iconTinder,
                  width: 55,
                  height: 55,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text('Tất cả đã chấm dứt rồi sao', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),),
                SizedBox(height: 8),
                Text(
                  'Nếu bạn chắc chắn không đăng kí Binder nữa. Thông tin của bạn sẽ được xóa',
                  style: TextStyle(fontSize: 15, color: Colors.black,),
                  textAlign: TextAlign.center,),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor:  Color.fromRGBO(234, 64, 128, 1),
                      ),
                      child: Text(
                        'Ở lại', style: TextStyle(fontSize: 19, color: Colors
                          .white, fontWeight: FontWeight.w600),)),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ElevatedButton(
                      onPressed: () async {
                        final signUp = context.read<CallDataProvider>();
                        await signUp.signOut();
                        context.pushReplacement('/login-home-screen');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Rời đi', style: TextStyle(fontSize: 19, color: Colors
                          .black, fontWeight: FontWeight.w600),)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
