import 'package:chat_app/Auth/widget/button_select_gender.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../widget/button_submit_page_view.dart';

class AddGenderPageSection extends StatelessWidget {
  const AddGenderPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);

    return SingleChildScrollView(
      child: Container(
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
                  const Text('Giới tính của bạn ?',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28
                    ),
                  ),
                  const SizedBox(height: 45,),
                  ButtonSelectGender(value: 'Nam'),
                  const SizedBox(height: 20),
                  ButtonSelectGender(value: 'Nữ'),
                  const SizedBox(height: 20),
                  ButtonSelectGender(value: 'Khác'),
                ],
              ),
            ),
            ButtonSubmitPageView(text: 'Tiếp theo',marginBottom: 70,
                color: pageProvider.isGenderEmpty ? Colors.grey : Colors.transparent,
                onPressed: () {
                  !pageProvider.isGenderEmpty ? pageProvider.nextPage() : null;
                  print('Giới tính: ${pageProvider.selectedGender}');
                }),
          ],
        ),
      ),
    );
  }
}
