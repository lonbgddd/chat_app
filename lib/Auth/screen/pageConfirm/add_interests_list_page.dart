import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/helpers_user_and_validators.dart';
import '../../widget/button_submit_page_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddInterestsListPageSection extends StatelessWidget {
  const AddInterestsListPageSection({Key? key}) : super(key: key);

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
                          pageProvider.newInterestsList.clear();
                          pageProvider.isInterestsEmpty = true;
                          print('Sở thích ${pageProvider.newInterestsList}');
                        },
                        child: Text(appLocal.textSkipButton, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600,fontSize: 17),),
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                   Text(appLocal.titleAddInterestsPage,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Text(appLocal.textContentInterests,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),

                ],
              ),

            ),
            const SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height / 1.75,
              padding: EdgeInsets.all(10),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  children: List.generate(HelpersUserAndValidators.interestsList(context).length , (index) {
                    final item = HelpersUserAndValidators.interestsList(context)[index];
                    final isSelected = HelpersUserAndValidators.getItemFromListIndex(context, HelpersUserAndValidators.interestsList(context),  pageProvider.newInterestsList).contains(item);
                    return InkWell(
                      onTap: (){
                          pageProvider.newInterestsList.length < 5
                              ? !isSelected ? pageProvider.newInterestsList.add(index) : pageProvider.newInterestsList.remove(index)
                              : isSelected ? pageProvider.newInterestsList.remove(index): null;
                          pageProvider.onInterestsListChanged();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10,  right: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: isSelected ? 2 : 1,
                              color: isSelected ? Color.fromRGBO(234, 64, 128, 1,) : Colors.grey ,
                            ),
                          ),
                          child: Text(item, style: TextStyle(color: Colors.black54,fontSize: 15,),textAlign: TextAlign.center,),
                        ),
                      ),
                    );

                  },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25,),
            ButtonSubmitPageView(text: '${appLocal.textNextButton} ${pageProvider.newInterestsList.length}/5',marginBottom: 70,
                color: pageProvider.isInterestsEmpty ? Colors.grey: Colors.transparent,
                onPressed: () {
                  !pageProvider.isInterestsEmpty ? pageProvider.nextPage() : null;
                  print('Sở thích ${pageProvider.newInterestsList}');
                }),
          ],
        ),
      ),
    );
  }
}
