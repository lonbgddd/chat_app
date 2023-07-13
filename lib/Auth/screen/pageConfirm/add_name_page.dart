import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../widget/button_submit_page_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddNamePageSection extends StatelessWidget {
  const AddNamePageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);
    final appLocal = AppLocalizations.of(context);

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
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
                 Text(appLocal.titleAddNamePage,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28
                  ),
                ),
                const SizedBox(height: 18,),
                TextField(
                  controller: pageProvider.nameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Color.fromRGBO(234, 64, 128, 1,),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 20),
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    constraints: BoxConstraints(
                      maxHeight: 40,
                    ),
                    hintText: appLocal.textHintEnterName,
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Color.fromRGBO(234, 64, 128, 1),width: 2),
                    ),
                  ),

                  onChanged: (value) {
                    pageProvider.onTextFieldNameChanged();
                  },
                ),
                const SizedBox(height: 10,),
                 Text(appLocal.textNotificationNamePage,
                  style: TextStyle(
                      fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500
                  ),
                ),

              ],
            ),
          ),
          ButtonSubmitPageView(text: appLocal.textNextButton, marginBottom: 20,
              color: pageProvider.isTextFieldNameEmpty ? Colors.grey : Colors.transparent ,
              onPressed: () {
                !pageProvider.isTextFieldNameEmpty ? pageProvider.nextPage() : null;
                print('Tên: ${pageProvider.nameController.text}');
              }),
        ],
      ),
    );
  }
}
