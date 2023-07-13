import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/app_assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widget/button_submit_page_view.dart';


class RulesPageSection extends StatelessWidget {
  const RulesPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);
    final appLocal = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
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
                    onPressed: () => pageProvider.showCustomDialog(context),
                    icon: SvgPicture.asset(
                      AppAssets.iconDelete,
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SvgPicture.asset(
                    AppAssets.iconTinder,
                    width: 45,
                    height: 45,
                    fit: BoxFit.contain,

                  ),
                  const SizedBox(height: 10,),
                   Text(appLocal.titleRulersPage,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Text(appLocal.contentRules,
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),

                  const SizedBox(height: 30,),
                   Text(appLocal.contentRule1,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                   Text(appLocal.contentRule1_1,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),

                  const SizedBox(height: 20,),
                   Text(appLocal.contentRule2,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  RichText(
                    textAlign: TextAlign.start,
                    text:TextSpan(
                      text: appLocal.contentRule2_1,
                      style: TextStyle(color: Colors.black,fontSize: 14, ),
                      children: <TextSpan>[
                        TextSpan(
                          text: appLocal.contentRule2_2,
                          style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),
                        ),
                      ],

                    ),
                  ),

                  const SizedBox(height: 20,),
                   Text(appLocal.contentRule3,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                   Text(appLocal.contentRule3_1,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  const SizedBox(height: 20,),
                   Text(appLocal.contentRule4,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                   Text(appLocal.contentRule4_1,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            ButtonSubmitPageView(text: appLocal.textNextButton,marginBottom: 70, color: Colors.transparent, onPressed: () => pageProvider.nextPage(),),
          ],
        ),
      ),
    );
  }
}
