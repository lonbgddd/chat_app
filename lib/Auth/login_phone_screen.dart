import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/changedNotify/login_phone.dart';
import '../config/helpers/helpers_user_and_validators.dart';

class LoginWithPhoneNumber extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Consumer<LoginPhoneProvider>(builder: (context, myProvider, _) {
      return Scaffold(
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
          body: SingleChildScrollView(
            child: Container(
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
                    height: 30,
                  ),

                  Row(
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
                          value: myProvider.country.isNotEmpty ? myProvider.country : null,
                          onChanged: (newValue) {
                            myProvider.selectedCountry(newValue!);
                          },
                          items: HelpersUserAndValidators.countryCodes
                              .map((Map<String, dynamic> item) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Text(
                                  '${item['display']} ${item['value']}'),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: context
                              .watch<LoginPhoneProvider>()
                              .textEditingController,
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
                          onChanged: (value) {myProvider.onTextFieldChanged();},
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  Visibility(
                      visible: myProvider.isErrorText,
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
                                onPressed: () async {
                                  !myProvider.isTextFieldEmpty ?  await myProvider.onSubmitPhone(context) : null;
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: !myProvider.isTextFieldEmpty
                                       ? Color.fromRGBO(234, 64, 128, 100,) : Colors.grey.shade400 ,
                            ),
                            child: Text('Tiếp tục', style: TextStyle(fontSize: 20, color: !myProvider.isTextFieldEmpty? Colors.white : Colors.black,fontWeight: FontWeight.w600),)),
                          ),
                        ],
                      ),

                ],
              ),
            ),
          ),
      );
    });
  }

}
