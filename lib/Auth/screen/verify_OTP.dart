import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../login_phone.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var smsCode = '';
  bool _isErrorSms = false;

  @override
  void initState() {
    super.initState();
  }


  Future<void> verify() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: LoginWithPhoneNumber.verify,
        smsCode: smsCode,
      );
      await auth.signInWithCredential(credential);

      context.go('/confirm-screen');
    } catch (e) {
      print('Lỗi xác minh số điện thoại: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.west,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mã của tôi là',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35
                    ),),
                  Center(
                    child: InkWell(
                      onTap: () {
                        print('object');
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 2,
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'RESEND',
                          style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                child: PinCodeTextField(
                    appContext: context,
                    cursorColor: Color.fromRGBO(234, 64, 128, 100,),
                    length: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    pinTheme: PinTheme(
                      borderWidth: 2,
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(10),
                      inactiveColor: Colors.grey,
                      selectedColor: Color.fromRGBO(234, 64, 128, 100,),
                    ),
                    onChanged: (value) {
                      smsCode = value;
                    }),
              ),
              const SizedBox(height: 10,),
              Visibility(
                visible: _isErrorSms,
                child: Text('Mã bạn nhập không hợp lệ- vui lòng thử lại', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 16,),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10,),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(

                    onPressed: (){
                      verify();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:  smsCode.length != 6 ? Colors.grey.shade400 : Color.fromRGBO(234, 64, 128, 100,),
                    ),
                    child: Text('Tiếp tục', style: TextStyle(fontSize: 20, color: smsCode.length != 6 ? Colors.black : Colors.white,fontWeight: FontWeight.w600),)),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
