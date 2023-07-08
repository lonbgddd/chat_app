import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SexualOrientationBottomSheet extends StatelessWidget {
  const SexualOrientationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<UpdateNotify>(
        builder: (context, updateProvider, child) => Stack(children: [
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            height: height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Khuynh hướng tính dục",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                  ),

                   Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Text(
                      "Chọn tối đa 3",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                  ),
                   ),

                  SizedBox(
                    height: height,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                        HelpersUserAndValidators.sexualOrientationList.length,
                        itemBuilder: (context, index) {
                          final item =
                          HelpersUserAndValidators.sexualOrientationList[index];
                          final isSelected = updateProvider.sexualOrientationList!.contains(item);
                          return InkWell(
                              onTap: () async {
                                updateProvider.sexualOrientationList!.length < 3
                                    ? !isSelected
                                    ? updateProvider.sexualOrientationList!.add(item)
                                    : updateProvider.sexualOrientationList!.remove(item)
                                    : isSelected
                                    ? updateProvider.sexualOrientationList!.remove(item)
                                    : null;
                                updateProvider.onDataChange();
                                await updateProvider.updateSexualOrientationList();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: index <
                                            HelpersUserAndValidators
                                                .sexualOrientationList.length - 1
                                            ? BorderSide(
                                            color: Colors.grey.shade200, width: 1)
                                            : BorderSide.none)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    if (isSelected)
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              229, 58, 69, 100),
                                          borderRadius: BorderRadius.circular(5.0)
                                        ),
                                       
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                  ],
                                ),
                              ));
                        }),
                  ),
                ],
              ),
            ),
          ),
          if (updateProvider.isLoading)
            Positioned.fill(
              child: Stack(
                children: [
                  // Nền mờ
                  const Opacity(
                    opacity: 0.7,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.black,
                    ),
                  ),
                  // Loading Indicator
                  Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: const Color.fromRGBO(234, 64, 128, 100),
                      size: 70,
                    ),
                  ),
                ],
              ),
            )
        ]));
  }
}
