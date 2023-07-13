import 'package:chat_app/Auth/widget/button_submit_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../config/changedNotify/login_phone.dart';
import '../config/helpers/helpers_user_and_validators.dart';

class LoginWithPhoneNumber extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);

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
                    child: Text(appLocal.titleEnterPhoneNumber,
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
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10) ,
                              hintText: appLocal.hintTextPhone,
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
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
                      child: Text(appLocal.textErrorEnterPhone, style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 16,),
                        textAlign: TextAlign.left,
                      ),
                    ),

                     Column(
                        children: [
                          const SizedBox(height: 25,),
                          RichText(
                            textAlign: TextAlign.start,
                            text:TextSpan(
                              text: appLocal.contentNotificationPhoneLogin1,
                              style: TextStyle(color: Colors.black,fontSize: 16, ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: appLocal.contentNotificationPhoneLogin2,
                                  style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 40,),
                          ButtonSubmitPageView(text:appLocal.textNextButton,marginBottom: 0,
                              color: !myProvider.isTextFieldEmpty ? Colors.transparent : Colors.grey,
                              onPressed: () async{
                                !myProvider.isTextFieldEmpty ?  await myProvider.onSubmitPhone(context) : null;
                              }),

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
