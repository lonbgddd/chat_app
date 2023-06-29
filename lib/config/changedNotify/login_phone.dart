import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../helpers/helpers_user_and_validators.dart';

class LoginPhoneProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController textEditingController = TextEditingController();
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

  void inputCode(String newValue) {
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
    if(!HelpersUserAndValidators.isValidPhoneNumber(textEditingController.text)){
      onTextFieldError();
      textEditingController.clear();
    }else {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '$country ${textEditingController.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            print('${e.message}');
          },
          codeSent: (String verificationId, int? resendToken) {
            codeVerify = verificationId;
            context.go('/login-home-screen/loginPhone/verify_otp');
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    }
  }

  Future<void> verify(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: codeVerify,
        smsCode: smsCode,
      );
      await auth.signInWithCredential(credential);
      context.go('/login-home-screen/confirm-screen');
    } catch (e) {
      smsError(true);
      print('Lỗi xác minh số điện thoại: $e');
    }
  }
}
