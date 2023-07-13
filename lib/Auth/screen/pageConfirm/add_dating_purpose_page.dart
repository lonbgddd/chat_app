import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/helpers_user_and_validators.dart';
import '../../widget/button_submit_page_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDatingPurposePageSection extends StatelessWidget {
  const AddDatingPurposePageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 300) / 2;
    final double itemWidth = size.width / 2;
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);
    final appLocal = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: ()  {
                      pageProvider.previousPage();
                    },
                    icon: Icon(Icons.west, color: Colors.grey, size: 30,),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(appLocal.titleAddDatingPurposePage,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10,),
                         Text(appLocal.textContentDatingPurpose,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: itemWidth / itemHeight,
                      children: List.generate(HelpersUserAndValidators.datingPurposeList(context).length, (index)  {
                        final item = HelpersUserAndValidators.datingPurposeList(context)[index];
                        return InkWell(
                          onTap: (){
                            pageProvider.onDatingPurposeChanged(index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == pageProvider.selectedIndexDatingPurpose ? Colors.white : Colors.grey.shade100,
                              border: Border.all(
                                color:index == pageProvider.selectedIndexDatingPurpose ? Color.fromRGBO(234, 64, 128, 1,): Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(HelpersUserAndValidators.emojiDatingPurposeList[index],width: 40,height: 40,),
                                const SizedBox(height: 10,),
                                Text(item,style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                ],
              ),
            ),
            ButtonSubmitPageView(text: appLocal.textNextButton,marginBottom: 70,
                color:  pageProvider.selectedIndexDatingPurpose != -1 ? Colors.transparent : Colors.grey,
                onPressed: () {
                  pageProvider.selectedIndexDatingPurpose != -1 ? pageProvider.nextPage() : null;
                  print('Mục đích: ${pageProvider.newDatingPurpose}');
                }),
          ],
        ),
      ),
    );
  }
}
