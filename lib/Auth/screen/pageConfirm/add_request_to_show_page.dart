import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../widget/button_select_request_to_show.dart';
import '../../widget/button_submit_page_view.dart';

class AddRequestToShowPageSection extends StatelessWidget {
  const AddRequestToShowPageSection({Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      pageProvider.previousPage();
                    },
                    icon: Icon(
                      Icons.west,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   Text(appLocal.titleAddRequestToShow,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28
                    ),
                  ),
                  const SizedBox(height: 45,),
                  ButtonSelectRequest(value: appLocal.genderSelectToShow('male')),
                  const SizedBox(height: 20),
                  ButtonSelectRequest(value: appLocal.genderSelectToShow('female')),
                  const SizedBox(height: 20),
                  ButtonSelectRequest(value: appLocal.genderSelectToShow('other')),
                ],
              ),
            ),

            ButtonSubmitPageView(text: appLocal.textNextButton,marginBottom: 70,
                color: pageProvider.isRequestToShowEmpty ? Colors.grey : Colors.transparent,
                onPressed: () {
                  !pageProvider.isRequestToShowEmpty ? pageProvider.nextPage() : null;
                  print('Yêu cầu: ${pageProvider.selectedRequestToShow}');
                }),
          ],
        ),
      ),
    );
  }
}
