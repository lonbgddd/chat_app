import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BasicInformationBottomSheet extends StatelessWidget {
  const BasicInformationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<UpdateNotify>(
      builder: (context, updateProvider, child) => Stack(
          children: [
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
                 Align(
                  alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context).basicInformationDialogTitle,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context).basicInformationDialogContent,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildZodiac(context,updateProvider),
                _buildAcademicLevel(context,updateProvider),
                _buildFamilyStyle(context,updateProvider),
                _buildPersonalityType(context,updateProvider),
                _buildLanguageOfLove(context, updateProvider)
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

  Widget _buildZodiac(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          AppLocalizations.of(context).basicInformationDialogZodiac,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.zodiacList(context).length, (index) {
              final item = HelpersUserAndValidators.zodiacList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.zodiac = index;
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
                        width: index == updateProvider.zodiac ? 2 : 1,
                        color: index == updateProvider.zodiac
                            ? const Color.fromRGBO(234, 64, 128, 1,)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.zodiac  ? Colors.black : Colors.black54,
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

  Widget _buildAcademicLevel(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
        AppLocalizations.of(context).basicInformationDialogEducation,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.academicLeverList(context).length,
            (index) {
              final item = HelpersUserAndValidators.academicLeverList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.academicLever = index;
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
                        width: index == updateProvider.academicLever ? 2 : 1,
                        color: index == updateProvider.academicLever
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
                        color: index == updateProvider.academicLever ? Colors.black : Colors.black54,
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

  Widget _buildFamilyStyle(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).basicInformationDialogFamily,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.familyStyleList(context).length,
            (index) {
              final item = HelpersUserAndValidators.familyStyleList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.familyStyle = index;
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
                        width: index == updateProvider.familyStyle ? 2 : 1,
                        color:  index == updateProvider.familyStyle
                            ? const Color.fromRGBO(234, 64, 128, 1,)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color:  index == updateProvider.familyStyle ? Colors.black : Colors.black54,
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

  Widget _buildPersonalityType(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).basicInformationDialogPersonality,
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
                  updateProvider.personalityType = !isSelected ? item : '';

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

  Widget _buildLanguageOfLove(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          AppLocalizations.of(context).basicInformationDialogLove,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.languageOfLoveList(context).length,
            (index) {
              final item = HelpersUserAndValidators.languageOfLoveList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.languageOfLove = index;
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
                        width:  index == updateProvider.languageOfLove  ? 2 : 1,
                        color:  index == updateProvider.languageOfLove
                            ? const Color.fromRGBO(234, 64, 128, 1,)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color:  index == updateProvider.languageOfLove  ? Colors.black : Colors.black54,
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
