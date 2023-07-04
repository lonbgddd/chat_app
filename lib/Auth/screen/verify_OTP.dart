
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../config/changedNotify/login_phone.dart';


class VerifyOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  const Text('Mã của tôi là',
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
                child: const Text('Mã bạn nhập không hợp lệ - vui lòng thử lại',
                  style: TextStyle(color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ElevatedButton(
                    onPressed: () async {
                      await Provider.of<LoginPhoneProvider>(
                          context, listen: false).verify(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:  Provider
                          .of<LoginPhoneProvider>(context, listen: false)
                          .smsCode.length != 6 ? Colors.grey.shade400 : Color.fromRGBO(234, 64, 128, 100,),
                    ),
                    child: Text('Tiếp tục', style: TextStyle(fontSize: 20,
                        color: Provider
                            .of<LoginPhoneProvider>(context, listen: false)
                            .smsCode
                            .length != 6 ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600),)),
              ),
            ],
          ),
        ),
    );
  }

  Widget countDown(BuildContext context) {
    return Countdown(
      seconds: 10,
      build: (BuildContext context, double time) =>
          Text('Gửi lại mã sau ${time.toInt().toString()}',style: const TextStyle(
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
        child: const Text(
          'Gửi lại',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}