import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:chat_app/home/profile/components/dating_purpose_bottom_sheet.dart';
import 'package:chat_app/home/profile/components/gender_bottom_sheet.dart';
import 'package:chat_app/home/profile/components/interest_bottom_sheet.dart';
import 'package:chat_app/home/profile/components/language_bottom_sheet.dart';
import 'package:chat_app/home/profile/components/sexual_orientation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'components/basic_information_row.dart';
import 'components/life_style_row.dart';
import 'components/update_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UpdateNotify>(context, listen: false).getUser(true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 210) / 2;
    final double itemWidth = size.width / 2;
    final updateProvider = Provider.of<UpdateNotify>(context);
    final appLocal = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () async {
        await Future.delayed(const Duration(seconds: 3)).then((value) async {
          updateProvider.loading();
          updateProvider.updateInputField();
          await Future.delayed(const Duration(seconds: 1));
          updateProvider.stopLoading();
        });
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(appLocal.updateProfileTitleAppbar,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 2,
            leading: IconButton(
              onPressed: () async {
                updateProvider.loading();
                updateProvider.updateInputField();
                await Future.delayed(const Duration(seconds: 1))
                    .then((value) => Navigator.of(context).pop());
                updateProvider.stopLoading();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(229, 58, 69, 100),
              ),
            ),
          ),
          body: Stack(children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Update image
                   SectionTitle(title: appLocal.updateProfilePhotosText),
                  UpdateImage(
                    itemWidth: itemWidth,
                    itemHeight: itemHeight,
                  ),

                  // introduceYourself
                   SectionTitle(
                    title: appLocal.updateProfileAboutMeText,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        right: 16.0, left: 16.0, bottom: 16.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        TextField(
                          controller:
                              updateProvider.introduceYourselfController,
                          keyboardType: TextInputType.multiline,
                          maxLength: 500,
                          textInputAction: TextInputAction.newline,
                          maxLines: null,
                          onChanged: (value) {
                            print(context
                                .read<UpdateNotify>()
                                .introduceYourselfController
                                .text);
                          },
                          decoration:  InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                            border: InputBorder.none,
                            hintText: appLocal.updateProfileAboutMeText,
                          ),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),

                  // interestList
                   SectionTitle(
                    title: appLocal.updateProfileHobbiesText,
                  ),
                  InkWell(
                    splashColor:  Color.fromRGBO(229, 58, 69, 100),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return  InterestBottomSheet();
                        },
                      ).whenComplete(() {
                        updateProvider.getUser(false);
                      });
                    },
                    child: Container(
                      padding:  EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0,right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(HelpersUserAndValidators.getItemFromListIndex(context,HelpersUserAndValidators.interestsList(context) ,updateProvider.interestsList).join(", "),
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade700,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileDatingPurposeText,
                  ),
                  InkWell(
                    splashColor: const Color.fromRGBO(229, 58, 69, 100),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return const DatingPurposeBottomSheet();
                        },
                      ).whenComplete(() {
                        updateProvider.getUser(false);
                      });
                    },
                    child: Container(
                      padding:  EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0,right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.grey.shade700,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          if (updateProvider.datingPurpose.toString().isNotEmpty &&
                              HelpersUserAndValidators.datingPurposeList(context)
                                  .contains(HelpersUserAndValidators.getItemFromIndex(context,HelpersUserAndValidators.datingPurposeList(context),updateProvider.datingPurpose)))
                            Image.asset(
                              HelpersUserAndValidators.emojiDatingPurposeList[updateProvider.datingPurpose!],
                              width: 24,
                              height: 24,
                            ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: Text(
                              updateProvider.datingPurpose.toString().isNotEmpty
                                  ? HelpersUserAndValidators.getItemFromIndex(context,HelpersUserAndValidators.datingPurposeList(context),updateProvider.datingPurpose!)
                                  : appLocal.emptyText,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade700,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileLanguagesIKnowText,
                  ),
                  InkWell(
                    splashColor: const Color.fromRGBO(229, 58, 69, 100),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return const LanguageBottomSheet();
                        },
                      ).whenComplete(() {
                        updateProvider.getUser(false);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0,right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.g_translate,
                            color: Colors.grey.shade700,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Text(
                              updateProvider.fluentLanguageList!.isNotEmpty
                                  ? updateProvider.fluentLanguageList!
                                      .join(', ')
                                  : appLocal.updateProfileLanguagesHintText,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade700,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileBasicInformationText,
                  ),
                  BasicInformationRow(
                    title: appLocal.basicInformationZodiacText,
                    content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.zodiacList(context), updateProvider.zodiac),
                    icon: AppAssets.iconZodiac,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: appLocal.basicInformationEducationText,
                    content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.academicLeverList(context), updateProvider.academicLever),
                    icon: AppAssets.iconAcademicLevel,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: appLocal.basicInformationFamilyText,
                    content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.familyStyleList(context), updateProvider.familyStyle),
                    icon: AppAssets.iconFamilyStyle,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: appLocal.basicInformationPersonalityText,
                    content: updateProvider.personalityType,
                    icon: AppAssets.iconPersonalityType,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: appLocal.basicInformationCommunicationText,
                    content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.communicateStyleList(context), updateProvider.communicateStyle),
                    icon: AppAssets.iconCommunicateStyle,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: appLocal.basicInformationLoveText,
                    content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.languageOfLoveList(context), updateProvider.languageOfLove),
                    icon: AppAssets.iconLanguageOfLove,
                    updateProvider: updateProvider,
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileLifestyleText,
                  ),
                  LifeStyleRow(
                      title: appLocal.lifestylePetText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.myPetList(context), updateProvider.myPet),
                      icon: AppAssets.iconMyPets,
                      updateProvider: updateProvider),

                  LifeStyleRow(
                      title: appLocal.lifestyleAlcoholText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.drinkingStatusList(context), updateProvider.drinkingStatus),
                      icon: AppAssets.iconDrinkingStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: appLocal.lifestyleSmokeText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.smokingStatusList(context), updateProvider.smokingStatus),
                      icon: AppAssets.iconSmokingStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: appLocal.lifestyleExerciseText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.sportsStatusList(context), updateProvider.sportsStatus),
                      icon: AppAssets.iconSportStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: appLocal.lifestyleDietaryText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.eatingStatusList(context), updateProvider.eatingStatus),
                      icon: AppAssets.iconEatingStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: appLocal.lifestyleMediaText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.socialNetworkStatusList(context), updateProvider.socialNetworkStatus),
                      icon: AppAssets.iconSocialNetworkStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: appLocal.lifestyleSleepText,
                      content: HelpersUserAndValidators.getItemFromIndex(context, HelpersUserAndValidators.sleepingHabitsStatusList(context), updateProvider.sleepingHabits),
                      icon: AppAssets.iconSleepingHabits,
                      updateProvider: updateProvider),
                   SectionTitle(
                    title: appLocal.updateProfileCompanyText,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    color: Colors.white,
                    child: TextField(
                      controller: updateProvider.companyController,
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: InputBorder.none,
                        hintText: appLocal.updateProfileCompanyHintText,
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SectionTitle(
                    title: appLocal.updateProfileSchoolText,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    color: Colors.white,
                    child: TextField(
                      controller: updateProvider.schoolController,
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: InputBorder.none,
                        hintText: appLocal.updateProfileSchoolHintText,
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileLivingText,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    color: Colors.white,
                    child: TextField(
                      controller: updateProvider.currentAddressController,
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: InputBorder.none,
                        hintText: appLocal.updateProfileLivingHintText,
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileGenderText,
                  ),
                  InkWell(
                    splashColor: const Color.fromRGBO(229, 58, 69, 100),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return const GenderBottomSheet();
                        },
                      ).whenComplete(() {
                        updateProvider.getUser(false);
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(),
                      child: Text(
                        updateProvider.gender!,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                   SectionTitle(
                    title: appLocal.updateProfileSexualText,
                  ),
                  InkWell(
                    splashColor: const Color.fromRGBO(229, 58, 69, 100),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return const SexualOrientationBottomSheet();
                        },
                      ).whenComplete(() {
                        updateProvider.getUser(false);
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(),
                      child: Text(
                        updateProvider.sexualOrientationList!.isNotEmpty
                            ? updateProvider.sexualOrientationList!.join(', ')
                            : appLocal.emptyText,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    height: 16.0,
                  ),
                ],
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
          ])),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, left: 16.0, bottom: 6.0),
      child: Text(
        title,
        style:  TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      ),
    );
  }
}
