import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class GenderBottomSheet extends StatelessWidget {
  const GenderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<UpdateNotify>(
        builder: (context, updateProvider, child) => Stack(children: [
              Container(
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                height: height * 0.70,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Tôi là...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: height * 2 / 3,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                HelpersUserAndValidators.genderList.length,
                            itemBuilder: (context, index) {
                              final item =
                                  HelpersUserAndValidators.genderList[index];
                              final isSelected = updateProvider.gender == item;
                              return InkWell(
                                  onTap: () async {
                                    updateProvider.gender = item;
                                    updateProvider.onDataChange();
                                    await updateProvider.updateGender();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: index <
                                                    HelpersUserAndValidators
                                                            .genderList.length - 1
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
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        if (isSelected)
                                          const Icon(
                                            Icons.check,
                                            color: Color.fromRGBO(
                                                229, 58, 69, 100),
                                            size: 20,
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
