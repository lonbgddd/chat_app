import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../widget/button_submit_page_view.dart';

class AddNamePageSection extends StatelessWidget {
  const AddNamePageSection({Key? key}) : super(key: key);

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
                const Text('What is your name?',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28
                  ),
                ),
                const SizedBox(height: 18,),
                TextField(
                  controller: pageProvider.nameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Color.fromRGBO(234, 64, 128, 100,),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 20),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    constraints: BoxConstraints(
                      maxHeight: 40,
                    ),
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Color.fromRGBO(234, 64, 128, 100,),width: 2),
                    ),
                  ),
                  onChanged: (value) {
                    pageProvider.onTextFieldNameChanged();
                  },
                ),
                const SizedBox(height: 10,),
                const Text('This is the content that will be displayed on your profile.\nPlease use your real name.',
                  style: TextStyle(
                      fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500
                  ),
                ),

              ],
            ),
          ),
          ButtonSubmitPageView(text: 'Next', marginBottom: 20,
              color: pageProvider.isTextFieldNameEmpty ? Colors.grey : Colors.transparent ,
              onPressed: () {
                !pageProvider.isTextFieldNameEmpty ? pageProvider.nextPage() : null;
                print('Name: ${pageProvider.nameController.text}');
              }),
        ],
      ),
    );
  }
}
