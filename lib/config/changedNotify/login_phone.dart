import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helpers/helpers_validators.dart';

class LoginPhoneProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var textEditingController = TextEditingController();
  bool isTextFieldEmpty = true;
  bool isErrorText = false;
  bool isErrorSms = false;
  String country = '+84';
  String codeVerify = '';
  String smsCode = '';
  bool resend = false;

  void onTextFieldChanged() {
    isTextFieldEmpty = textEditingController.text.isEmpty;
    notifyListeners();
  }

  void onTextFieldError() {
    isErrorText = !isErrorText;
    notifyListeners();
  }

  void selectedCountry(String newValue) {
    country = newValue;
    notifyListeners();
  }

  void nhapCode(String newValue) {
    smsCode = newValue;
    notifyListeners();
  }
  void Resend(bool value) {
    resend = value;
    notifyListeners();
  }
  void smsError(bool value){
    isErrorSms = value;
    notifyListeners();
  }

  Future<void> onSubmitPhone(BuildContext context) async {
    // if(!HelpersValidators.isValidPhoneNumber(textEditingController.text)){
    //   onTextFieldError();
    //   textEditingController.clear();
    //   notifyListeners();
    // }else {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$country ${textEditingController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          codeVerify = verificationId;
          context.go('/login/verify_otp');
        },
        codeAutoRetrievalTimeout: (String verificationId) {});

  }

  Future<void> verify(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: codeVerify,
        smsCode: smsCode,
      );
      await auth.signInWithCredential(credential);
      context.go('/confirm-screen');
    } catch (e) {
      smsError(true);
      print('Lỗi xác minh số điện thoại: $e');
    }
  }
}
