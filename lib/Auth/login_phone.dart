import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class LoginWithPhoneNumber extends StatefulWidget{
  const LoginWithPhoneNumber({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<StatefulWidget> createState() {
    return LoginWithPhoneNumberState();
  }

}
class LoginWithPhoneNumberState extends State<LoginWithPhoneNumber>{
  TextEditingController _textEditingController = TextEditingController();
  bool _isTextFieldEmpty = true;
  bool _isErrorText = false;



  List<Map<String, dynamic>> countryCodes = [
    {'display': 'VN', 'value': '+84'},
    {'display': 'US', 'value': '+1'},
    {'display': 'UK', 'value': '+44'},
    // Thêm các quốc gia khác vào đây
  ];
  String selectedCountry = '+84';

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextFieldChanged);
  }
  void _onTextFieldChanged() {
    setState(() {
      _isTextFieldEmpty = _textEditingController.text.isEmpty;
    });
  }
  void _onTextFieldError() {
    setState(() {
      _isErrorText = !_isErrorText;
    });
  }


  Future<void> onSubmitPhone() async {
    if(!HelpersValidators.isValidPhoneNumber(_textEditingController.text)){
        _onTextFieldError();
        _textEditingController.clear();
    }else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+84384745334',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          LoginWithPhoneNumber.verify = verificationId;
          context.go('/login/verify_otp');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      context.go('/login/verify_otp');
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
          ), iconTheme: IconThemeData(
            color: Colors.grey.shade800
        ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Text('Số điện thoại của tôi là ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 35
                  ),),
              ),
              const SizedBox(
                height: 40,
              ),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey,width: 1.5),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:Color.fromRGBO(234, 64, 128, 100,),width: 2),
                            ),
                          ),
                          value: selectedCountry.isNotEmpty ? selectedCountry : null,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                            });
                          },
                          items: countryCodes.map((Map<String, dynamic> item) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Text('${item['display']} ${item['value']}'),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: _textEditingController,
                          keyboardType: TextInputType.number,
                          cursorColor: Color.fromRGBO(234, 64, 128, 100,),
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 18),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10) ,
                              hintText: 'Nhập số điện thoại',
                              hintStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey,width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:Color.fromRGBO(234, 64, 128, 100,),width: 2),
                              ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Visibility(
                visible: _isErrorText,
                child: Text('Vui lòng nhập số điện thoại hợp lệ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 16,),
                  textAlign: TextAlign.left,
                ),
              ),

              Column(
                children: [
                  const SizedBox(height: 25,),
                  RichText(
                    textAlign: TextAlign.start,
                    text:TextSpan(
                      text: 'Khi bạn nhấn Tiếp tục, Binder sẽ gửi cho bạn một tin nhắn có chứa mã xác thực. Bạn có thế phải trả phí tin nhắn và dữ liệu.Số điện thoại được xác thực dùng để đăng nhập. ',
                      style: TextStyle(color: Colors.black,fontSize: 16, ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Tìm hiểu chuyện gì đã xảy ra khi số điện thoại của bạn thay đổi.',
                          style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),
                        ),

                      ],

                    ),
                  ),
                  const SizedBox(height: 40,),

                  Container(
                    width:  MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: _isTextFieldEmpty ? null : () {onSubmitPhone();},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: _isTextFieldEmpty ? Colors.grey.shade400 : Color.fromRGBO(234, 64, 128, 100,),
                        ),
                        child: Text('Tiếp tục', style: TextStyle(fontSize: 20, color:_isTextFieldEmpty ? Colors.black : Colors.white,fontWeight: FontWeight.w600),)),
                  ),
                ],
              ),
            ],
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.west,
                color: Colors.black,
                size: 42,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text('My number is',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26
                      ),),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              value: selectedCountry.isNotEmpty ? selectedCountry : null,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCountry = newValue!;
                                });
                              },
                              items: countryCodes.map((Map<String, dynamic> item) {
                                return DropdownMenuItem<String>(
                                  value: item['value'],
                                  child: Text('${item['display']} ${item['value']}'),
                                );
                              }).toList(),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10) ,
                                  hintText: 'Number phone',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      )
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '$selectedCountry ${controller.text}' ,
                              verificationCompleted: (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {
                                print('${e.message}');
                              },
                              codeSent: (String verificationId, int? resendToken) {
                                LoginWithPhoneNumber.verify = verificationId;
                                context.goNamed('verify_otp', queryParameters: {'phoneNumber':'$selectedCountry${controller.text}'});
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.deepPurpleAccent,
                          ),
                          child: const Text('SEND THE CODE')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}
