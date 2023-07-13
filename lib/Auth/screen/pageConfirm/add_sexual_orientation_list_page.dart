import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/helpers_user_and_validators.dart';
import '../../widget/button_submit_page_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddSexualOrientationListPageSection extends StatelessWidget {
  const AddSexualOrientationListPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);
    final appLocal = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: ()  {
                          pageProvider.previousPage();
                        },
                        icon: Icon(Icons.west, color: Colors.grey, size: 30,),
                      ),
                      InkWell(
                        onTap: () {
                          pageProvider.nextPage();
                          pageProvider.newSexualOrientationList.clear();
                          pageProvider.isSexualOrientationEmpty = true;},
                        child: Text(appLocal.textSkipButton, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600,fontSize: 17),),
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                   Text(appLocal.titleAddAddSexualOrientationPage,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Text(appLocal.textMaxItemSexual,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: HelpersUserAndValidators.sexualOrientationList(context).length,
                itemBuilder: (BuildContext context, int index) {
                  final item = HelpersUserAndValidators.sexualOrientationList(context)[index];
                  final isSelected = HelpersUserAndValidators.getItemFromListIndex(context, HelpersUserAndValidators.sexualOrientationList(context), pageProvider.newSexualOrientationList).contains(item);
                  return ListTile(
                    title: Text(item, style: TextStyle(fontWeight:  isSelected ? FontWeight.w700 : FontWeight.w400 ),),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                    trailing: isSelected ? Icon(Icons.check, color: Color.fromRGBO(234, 64, 128, 1,),) : null,
                    onTap: () {
                      pageProvider.newSexualOrientationList.length < 3
                          ? !isSelected ? pageProvider.newSexualOrientationList.add(index) : pageProvider.newSexualOrientationList.remove(index)
                          : isSelected ? pageProvider.newSexualOrientationList.remove(index) : null;
                      pageProvider.onSexualOrientationListChanged();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 25,),
            ButtonSubmitPageView(text: appLocal.textNextButton,marginBottom: 70,
                color: pageProvider.isSexualOrientationEmpty ? Colors.grey : Colors.transparent,
                onPressed: () {
                  !pageProvider.isSexualOrientationEmpty ? pageProvider.nextPage() : null;
                  print('list sexual: ${pageProvider.newSexualOrientationList}');
                }),

          ],
        ),
      ),
    );
  }
}
