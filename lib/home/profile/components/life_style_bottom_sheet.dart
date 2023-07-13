import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LifeStyleBottomSheet extends StatelessWidget {
  const LifeStyleBottomSheet({super.key});

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
                        await updateProvider.updateLifeStyle();
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
                  child: Text(
                    AppLocalizations.of(context).lifeStyleDialogTitle,
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
                  AppLocalizations.of(context).lifeStyleDialogContent,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildPets(context,updateProvider),
                _buildDrinkingStatus(context,updateProvider),
                _buildSmokingStatus(context,updateProvider),
                _buildSportStatus(context,updateProvider),
                _buildEatingStatus(context,updateProvider),
                _buildSocialNetworkStatus(context,updateProvider),
                _buildSleepingHabits(context,updateProvider)
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

  Widget _buildPets(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogPetText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.myPetList(context).length,
            (index) {
              final item = HelpersUserAndValidators.myPetList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.myPet = index;
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
                        width: index == updateProvider.myPet  ? 2 : 1,
                        color: index == updateProvider.myPet
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.myPet ? Colors.black : Colors.black54,
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

  Widget _buildDrinkingStatus(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogAlcoholText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.drinkingStatusList(context).length,
            (index) {
              final item = HelpersUserAndValidators.drinkingStatusList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.drinkingStatus = index ;
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
                        width: index == updateProvider.drinkingStatus ? 2 : 1,
                        color: index == updateProvider.drinkingStatus
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.drinkingStatus ? Colors.black : Colors.black54,
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

  Widget _buildSmokingStatus(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogSmokeText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.smokingStatusList(context).length,
            (index) {
              final item = HelpersUserAndValidators.smokingStatusList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.smokingStatus =  index;

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
                        width: index == updateProvider.smokingStatus ? 2 : 1,
                        color: index == updateProvider.smokingStatus
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.smokingStatus ? Colors.black : Colors.black54,
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

  Widget _buildSportStatus(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogExerciseText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.sportsStatusList(context).length,
            (index) {
              final item = HelpersUserAndValidators.sportsStatusList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.sportsStatus = index;
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
                        width: index == updateProvider.sportsStatus ? 2 : 1,
                        color: index == updateProvider.sportsStatus
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color:  index == updateProvider.sportsStatus ? Colors.black : Colors.black54,
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

  Widget _buildEatingStatus(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogEatText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.eatingStatusList(context).length,
            (index) {
              final item = HelpersUserAndValidators.eatingStatusList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.eatingStatus =  index;
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
                        width:  index == updateProvider.eatingStatus ? 2 : 1,
                        color: index == updateProvider.eatingStatus
                            ? const Color.fromRGBO(234, 64, 128, 1,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.eatingStatus  ? Colors.black : Colors.black54,
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

  Widget _buildSocialNetworkStatus(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogMediaText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.socialNetworkStatusList(context).length,
            (index) {
              final item =
              HelpersUserAndValidators.socialNetworkStatusList(context)[index];

              return InkWell(
                onTap: () {
                  updateProvider.socialNetworkStatus = index;
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
                        width: index == updateProvider.socialNetworkStatus  ? 2 : 1,
                        color: index == updateProvider.socialNetworkStatus
                            ? const Color.fromRGBO(234, 64, 128, 1,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.socialNetworkStatus ? Colors.black : Colors.black54,
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

  Widget _buildSleepingHabits(BuildContext context,UpdateNotify updateProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           AppLocalizations.of(context).lifeStyleDialogSleepingText,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersUserAndValidators.sleepingHabitsStatusList(context).length,
            (index) {
              final item = HelpersUserAndValidators.sleepingHabitsStatusList(context)[index];
              return InkWell(
                onTap: () {
                  updateProvider.sleepingHabits = index;
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
                        width: index == updateProvider.sleepingHabits ? 2 : 1,
                        color: index == updateProvider.sleepingHabits
                            ? const Color.fromRGBO(234, 64, 128,1,)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: index == updateProvider.sleepingHabits ? Colors.black : Colors.black54,
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
