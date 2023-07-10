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

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    Provider.of<UpdateNotify>(context, listen: false).getUser(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 210) / 2;
    final double itemWidth = size.width / 2;
    final updateProvider = Provider.of<UpdateNotify>(context);
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
            title: Text(
              "Chỉnh sửa hồ sơ",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 4,
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
                  const SectionTitle(title: "Ảnh"),
                  UpdateImage(
                    itemWidth: itemWidth,
                    itemHeight: itemHeight,
                  ),

                  // introduceYourself
                  const SectionTitle(
                    title: "Giới thiệu bản thân",
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
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                            border: InputBorder.none,
                            hintText: "Giới thiệu bản thân",
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
                  const SectionTitle(
                    title: "Sở thích",
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
                          return const InterestBottomSheet();
                        },
                      ).whenComplete(() {
                        updateProvider.getUser(false);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              updateProvider.interestsList!.join(", "),
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
                  const SectionTitle(
                    title: "Mục đích hẹn hò",
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
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
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
                          if (updateProvider.datingPurpose!.isNotEmpty &&
                              HelpersUserAndValidators.datingPurposeList
                                  .contains(updateProvider.datingPurpose))
                            Image.asset(
                              HelpersUserAndValidators.emojiDatingPurposeList[
                                  HelpersUserAndValidators.datingPurposeList
                                      .indexOf(updateProvider.datingPurpose!)],
                              width: 24,
                              height: 24,
                            ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: Text(
                              updateProvider.datingPurpose!.isNotEmpty
                                  ? updateProvider.datingPurpose!
                                  : "Trống",
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
                  const SectionTitle(
                    title: "Ngôn ngữ tôi biết",
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
                          left: 16.0, top: 16.0, bottom: 16.0),
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
                                  : "Thêm ngôn ngữ",
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
                  const SectionTitle(
                    title: "Thông tin cơ bản",
                  ),
                  BasicInformationRow(
                    title: "Cung hoàng đạo",
                    content: updateProvider.zodiac,
                    icon: AppAssets.iconZodiac,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: "Giáo dục",
                    content: updateProvider.academicLever,
                    icon: AppAssets.iconAcademicLevel,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: "Gia đình tương lai",
                    content: updateProvider.familyStyle,
                    icon: AppAssets.iconFamilyStyle,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: "Kiểu tính cách",
                    content: updateProvider.personalityType,
                    icon: AppAssets.iconPersonalityType,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: "Phong cách giao tiếp",
                    content: updateProvider.communicateStyle,
                    icon: AppAssets.iconCommunicateStyle,
                    updateProvider: updateProvider,
                  ),
                  BasicInformationRow(
                    title: "Ngôn ngữ tình yêu",
                    content: updateProvider.languageOfLove,
                    icon: AppAssets.iconLanguageOfLove,
                    updateProvider: updateProvider,
                  ),
                  const SectionTitle(
                    title: "Phong cách sống",
                  ),
                  LifeStyleRow(
                      title: "Thú cưng",
                      content: updateProvider.myPet,
                      icon: AppAssets.iconMyPets,
                      updateProvider: updateProvider),

                  LifeStyleRow(
                      title: "Về việc uống rượu bia",
                      content: updateProvider.drinkingStatus,
                      icon: AppAssets.iconDrinkingStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: "Bạn có hay hút thuốc",
                      content: updateProvider.smokingStatus,
                      icon: AppAssets.iconSmokingStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: "Tập luyện",
                      content: updateProvider.sportsStatus,
                      icon: AppAssets.iconSportStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: "Chế độ ăn uống",
                      content: updateProvider.eatingStatus,
                      icon: AppAssets.iconEatingStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: "Truyền thông",
                      content: updateProvider.socialNetworkStatus,
                      icon: AppAssets.iconSocialNetworkStatus,
                      updateProvider: updateProvider),
                  LifeStyleRow(
                      title: "Thói quen ngủ",
                      content: updateProvider.sleepingHabits,
                      icon: AppAssets.iconSleepingHabits,
                      updateProvider: updateProvider),
                  const SectionTitle(
                    title: "Công ty",
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    color: Colors.white,
                    child: TextField(
                      controller: updateProvider.companyController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: InputBorder.none,
                        hintText: "Thêm công ty",
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SectionTitle(
                    title: "Trường",
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    color: Colors.white,
                    child: TextField(
                      controller: updateProvider.schoolController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: InputBorder.none,
                        hintText: "Thêm tên trường",
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SectionTitle(
                    title: "Đang sống tại",
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    color: Colors.white,
                    child: TextField(
                      controller: updateProvider.currentAddressController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        border: InputBorder.none,
                        hintText: "Thêm thành phố",
                      ),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SectionTitle(
                    title: "Giới tính",
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
                  const SectionTitle(
                    title: "Khuynh hướng tính dục",
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
                            : "Trống",
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
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
