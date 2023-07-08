import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class BasicInformationBottomSheet extends StatelessWidget {
  const BasicInformationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<UpdateNotify>(
      builder: (context, updateProvider, child) => Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          height: height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 36,
                        )),
                    IconButton(
                      onPressed: () async {
                        updateProvider.loading();
                        await updateProvider.updateBasicInformation();
                        await Future.delayed(const Duration(seconds: 1))
                            .then((value) => Navigator.of(context).pop());
                        updateProvider.stopLoading();
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.indigo,
                        size: 36,
                      ),
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Thông tin thêm về tôi",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Thêm thông tin về bạn để mọi người hiểu rõ hơn về con người tuyệt vời của bạn.",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildZodiac(updateProvider),
                _buildAcademicLevel(updateProvider),
                _buildFamilyStyle(updateProvider),
                _buildPersonalityType(updateProvider),
                _buildLanguageOfLove(updateProvider)
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
      ]),
    );
  }

  Widget _buildZodiac(UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cung hoàng đạo của bạn là gì ?",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.zodiacList.length,
            (index) {
              final item = HelpersUserAndValidators.zodiacList[index];
              final isSelected = updateProvider.zodiac! == item;
              return InkWell(
                onTap: () {
                  updateProvider.zodiac = !isSelected ? item : "";

                  updateProvider.onDataChange();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                100,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black54,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildAcademicLevel(UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trình độ học vấn của bạn",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.academicLeverList.length,
            (index) {
              final item = HelpersUserAndValidators.academicLeverList[index];
              final isSelected = updateProvider.academicLever! == item;
              return InkWell(
                onTap: () {
                  updateProvider.academicLever = !isSelected ? item : "";

                  updateProvider.onDataChange();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                100,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black54,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildFamilyStyle(UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bạn muốn có con không ?",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.familyStyleList.length,
            (index) {
              final item = HelpersUserAndValidators.familyStyleList[index];
              final isSelected = updateProvider.familyStyle! == item;
              return InkWell(
                onTap: () {
                  updateProvider.familyStyle = !isSelected ? item : "";

                  updateProvider.onDataChange();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                100,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black54,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildPersonalityType(UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kiểu tính cách ?",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.personalityTypeList.length,
            (index) {
              final item = HelpersUserAndValidators.personalityTypeList[index];
              final isSelected = updateProvider.personalityType! == item;
              return InkWell(
                onTap: () {
                  updateProvider.personalityType = !isSelected ? item : "";

                  updateProvider.onDataChange();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                100,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black54,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildLanguageOfLove(UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ngôn ngữ tình yêu ?",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.languageOfLoveList.length,
            (index) {
              final item = HelpersUserAndValidators.languageOfLoveList[index];
              final isSelected = updateProvider.languageOfLove! == item;
              return InkWell(
                onTap: () {
                  updateProvider.languageOfLove = !isSelected ? item : "";

                  updateProvider.onDataChange();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                100,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.black54,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }
}
