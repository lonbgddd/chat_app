import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class InterestBottomSheet extends StatelessWidget {
  const InterestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final appLocal = AppLocalizations.of(context);

    return Consumer<UpdateNotify>(
      builder: (context, updateProvider, child) => Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          height: height,
          child: Column(
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
                  InkWell(
                    onTap: () async {
                      updateProvider.loading();
                      await updateProvider.updateInterestsList();
                      await Future.delayed(const Duration(seconds: 1)).then((value) => Navigator.of(context).pop());
                      updateProvider.stopLoading();
                    },
                    child:  Text(
                      appLocal.interestDialogDoneText,
                      style: TextStyle(
                          color: Color.fromRGBO(229, 58, 69, 100),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                   Expanded(
                      child: Text(
                        appLocal.interestDialogTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      child: Text(
                        "${updateProvider.interestsList!.length} ${appLocal.interestDialogOutOfText}",
                        style:  TextStyle(color: Colors.black),
                      ))
                ],
              ),
              if (updateProvider.interestsList!.isEmpty)
                Padding(
                  padding:  EdgeInsets.only(top: 20.0),
                  child: Text(appLocal.interestDialogContent,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (value) {
                    updateProvider.searchInterest(value,context);
                  },
                  controller: updateProvider.searchInterestController,
                  decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    border: InputBorder.none,
                    hintText: appLocal.interestDialogSearchText,
                  ),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(children: [
                  Wrap(
                    children: List.generate(HelpersUserAndValidators.interestsList(context).length, (index) {
                        final item = HelpersUserAndValidators.interestsList(context)[index];
                        final isSelected = HelpersUserAndValidators.getItemFromListIndex(context, HelpersUserAndValidators.interestsList(context), updateProvider.interestsList).contains(item);
                        return InkWell(
                          onTap: () {
                            updateProvider.interestsList!.length < 5
                                ? !isSelected
                                ? updateProvider.interestsList!.add(index)
                                : updateProvider.interestsList!.remove(index)
                                : isSelected
                                ? updateProvider.interestsList!.remove(index)
                                : null;
                            updateProvider.onDataChange();
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 10, right: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: isSelected ? 2 : 1,
                                  color: isSelected
                                      ? const Color.fromRGBO(234, 64, 128, 1,)
                                      : Colors.grey,
                                ),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.black54,
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
                ]),
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
                    color: const Color.fromRGBO(234, 64, 128, 1),
                    size: 70,
                  ),
                ),
              ],
            ),
          )
      ]),
    );
  }
}