import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/app_assets.dart';
import 'package:flutter_svg/svg.dart';

import '../../widget/button_submit_page_view.dart';


class RulersPageSection extends StatelessWidget {
  const RulersPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);

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
                  const Text('Welcome to Binder.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Please abide by these general rules.',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),

                  const SizedBox(height: 30,),
                  const Text('Be yourself.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text('Ensure that your photos, age, and bio are all genuine.',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Ensure safety.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  RichText(
                    textAlign: TextAlign.start,
                    text:TextSpan(
                      text: 'Do not rush to share personal information. ',
                      style: TextStyle(color: Colors.black,fontSize: 14, ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Practice safe dating.',
                          style: TextStyle(
                              decoration: TextDecoration.underline, fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],

                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Behave properly.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text('Respect others and treat them the way you want to be treated.',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Always be proactive.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text('Always report bad behavior.',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            ButtonSubmitPageView(text: 'Next',marginBottom: 70, color: Colors.transparent, onPressed: () => pageProvider.nextPage(),),
          ],
        ),
      ),
    );
  }
}
