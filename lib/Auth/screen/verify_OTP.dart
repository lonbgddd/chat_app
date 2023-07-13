import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../config/changedNotify/login_phone.dart';
import '../widget/button_submit_page_view.dart';


class VerifyOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.west,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(appLocal.titleEnterOTP,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35
                    ),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                       Text('${Provider.of<LoginPhoneProvider>(context, listen: false)
                           .textEditingController.text}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20
                        ),),
                      const SizedBox(
                        width: 10,
                      ),
                      Center(
                          child: context
                              .watch<LoginPhoneProvider>()
                              .resend ? resend(context) : countDown(context)
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                      appContext: context,
                      cursorColor: const Color.fromRGBO(234, 64, 128, 100,),
                      length: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      pinTheme: PinTheme(
                        borderWidth: 2,
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(10),
                        inactiveColor: Colors.grey,
                        selectedColor: const Color.fromRGBO(234, 64, 128, 100,),
                      ),
                      onChanged: (value) {
                        Provider.of<LoginPhoneProvider>(context, listen: false)
                            .inputCode(value);
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(height: 10),
              Visibility(
                visible: context
                    .watch<LoginPhoneProvider>()
                    .isErrorSms,
                child:  Text(appLocal.textErrorOTP,
                  style: TextStyle(color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,),
                  textAlign: TextAlign.left,
                ),
              ),


              ButtonSubmitPageView(text:appLocal.textNextButton,marginBottom: 0,
                  color:  Provider.of<LoginPhoneProvider>(context, listen: false).smsCode.length == 6
                      ? Colors.transparent : Colors.grey,
                  onPressed: () async{
                    await Provider.of<LoginPhoneProvider>(context, listen: false).verify(context);
                  }),

            ],
          ),
        ),
    );
  }

  Widget countDown(BuildContext context) {
    return Countdown(
      seconds: 10,
      build: (BuildContext context, double time) =>
          Text('${AppLocalizations.of(context)!.textResendOTP} ${time.toInt().toString()}',style: const TextStyle(
            fontSize: 20,
          ),),
      interval: const Duration(milliseconds: 1000),
      onFinished: () {
        context.read<LoginPhoneProvider>().Resend(true);
      },
    );
  }

  Widget resend(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.read<LoginPhoneProvider>().Resend(false);
        context.read<LoginPhoneProvider>().smsError(false);
        await Provider.of<LoginPhoneProvider>(
            context, listen: false).onSubmitPhone(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              width: 2,
              color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child:  Text(AppLocalizations.of(context)!.textButtonResendOTP,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}