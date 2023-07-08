import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class DatingPurposeBottomSheet extends StatelessWidget {
  const DatingPurposeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 300) / 2;
    final double itemWidth = size.width / 2;
    final double height = MediaQuery.of(context).size.height;
    return Consumer<UpdateNotify>(
        builder: (context, updateProvider, child) => Stack(children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                height: height * 0.70,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Bây giờ mình đang tìm...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Chia sẻ mục đích để tìm được \"người ấy\"!",
                        style: TextStyle(color: Colors.grey.shade700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: height * 2 / 3,
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: itemWidth / itemHeight,
                          children: List.generate(
                              HelpersUserAndValidators.datingPurposeList.length,
                              (index) {
                            final item = HelpersUserAndValidators
                                .datingPurposeList[index];
                            return InkWell(
                              onTap: () async {
                                updateProvider.datingPurpose = item;
                                updateProvider.loading();
                                await updateProvider.updateDatingPurpose();
                                await Future.delayed(const Duration(seconds: 1));
                                updateProvider.stopLoading();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: item == updateProvider.datingPurpose
                                      ? Colors.white
                                      : Colors.grey.shade100,
                                  border: Border.all(
                                    color: item == updateProvider.datingPurpose
                                        ? const Color.fromRGBO(
                                            234,
                                            64,
                                            128,
                                            100,
                                          )
                                        : Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      HelpersUserAndValidators
                                          .emojiDatingPurposeList[index],
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
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
