import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenderRadioButton extends StatelessWidget {
  GenderRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.selectedValue,
      required this.onChanged});
  final String title;
  final SingingCharacter value;
  SingingCharacter selectedValue;
  Function(SingingCharacter?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<SingingCharacter>(
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      tileColor: const Color.fromRGBO(229, 58, 69, 100).withOpacity(0.2),
      value: value,
      groupValue: selectedValue,
      onChanged: onChanged,
    );
  }
}
