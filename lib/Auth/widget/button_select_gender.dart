import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/confirm_profile_watch.dart';
class ButtonSelectGender extends StatelessWidget {
  String value;

  ButtonSelectGender({required this.value});


  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);

    final isSelected = pageProvider.selectedGender == value;
    return InkWell(
      onTap: () {
        pageProvider.selectedGender = value;
        pageProvider.onGenderChanged();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color.fromRGBO(234, 64, 128, 1,) : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
