import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class PinCodeCustom extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final String hintText;
  final Function(String) onChange;

  const PinCodeCustom(
      {Key? key,
        required this.controller,
        required this.focusNode,
        required this.length,
        required this.hintText,
        required this.onChange,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  PinCodeTextField(
      appContext: context,
      controller: controller,
      focusNode: focusNode,
      cursorColor: const Color.fromRGBO(234, 64, 128, 100,),
      length: length,
      hintCharacter: hintText,
      textStyle: TextStyle(fontSize: 22) ,
      keyboardType: TextInputType.number,
      enablePinAutofill: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        borderWidth: 0,
        fieldWidth: 30,
        fieldHeight: 30,
        shape: PinCodeFieldShape.underline,
        borderRadius: BorderRadius.circular(10),
        inactiveColor: Colors.white,
        selectedColor: Colors.white,
        activeColor: Colors.white,
      ),
      onChanged: onChange,
    );
  }
}
