import 'package:chat_app/Auth/widget/pin_code_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../widget/button_submit_page_view.dart';

class AddBirthdayPageSection extends StatelessWidget {
  const AddBirthdayPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: ()  {
                    pageProvider.previousPage();
                  },
                  icon: Icon(Icons.west, color: Colors.grey, size: 30,),
                ),
                const SizedBox(height: 15,),
                const Text('What is your date of birth?',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28
                  ),
                ),
                const SizedBox(height: 35,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: PinCodeCustom(controller: pageProvider.dayController, focusNode: pageProvider.dayFocusNode, length: 2,hintText: 'D',onChange: (value){
                        if (value.length == 2) {
                          FocusScope.of(context).requestFocus(pageProvider.monthFocusNode);
                        }
                        pageProvider.onBirthdayChange(value);}),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                      child: Text('/',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 20
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: PinCodeCustom(controller: pageProvider.monthController, focusNode: pageProvider.monthFocusNode, length: 2,hintText: 'M',onChange:  (value){
                        if (value.length == 2) {
                          FocusScope.of(context).requestFocus(pageProvider.yearFocusNode);
                        }
                        pageProvider.onBirthdayChange(value);}),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                      child: Text('/',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 20
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: PinCodeCustom(controller: pageProvider.yearController, focusNode: pageProvider.yearFocusNode, length: 4,hintText: 'Y',onChange:  (value){
                        if (value.length == 4) {
                          SystemChannels.textInput.invokeMethod('TextInput.show');
                        }
                        pageProvider.onBirthdayChange(value);
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Visibility(
                  visible: pageProvider.isErrorBirthday,
                  child: Text('Please enter a valid date of birth', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 16,),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text('Your profile will display your age, not your date of birth.',
                  style: TextStyle(
                      fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
          ButtonSubmitPageView(text: 'Next',marginBottom: 30,
              color: pageProvider.isBirthdayEmpty ? Colors.grey : Colors.transparent,
              onPressed: () {
                !pageProvider.isBirthdayEmpty ? pageProvider.nextPage() : null;
                print('Age: ${pageProvider.birthday}');
              }),


        ],
      ),
    );
  }
}
