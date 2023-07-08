import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
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
                      await updateProvider.updateFluentLanguageList();
                      await Future.delayed(const Duration(seconds: 1))
                          .then((value) => Navigator.of(context).pop());
                      updateProvider.stopLoading();
                    },
                    child: const Text(
                      "Xong",
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
                  const Expanded(
                      child: Text(
                    "Ngôn ngữ tôi biết",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  )),
                  Expanded(
                      child: Text(
                    "${updateProvider.fluentLanguageList!.length} trong tổng số 5",
                    style: const TextStyle(color: Colors.black),
                  ))
                ],
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
                    updateProvider.searchLanguage(value);
                  },
                  controller: updateProvider.searchLanguageController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    border: InputBorder.none,
                    hintText: "Tìm kiếm ngôn ngữ",
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
                    children: List.generate(
                      updateProvider.filteredLanguageList.length,
                      (index) {
                        final item = updateProvider.filteredLanguageList[index];
                        final isSelected =
                            updateProvider.fluentLanguageList!.contains(item);
                        return InkWell(
                          onTap: () {
                            updateProvider.fluentLanguageList!.length < 5
                                ? !isSelected
                                    ? updateProvider.fluentLanguageList!
                                        .add(item)
                                    : updateProvider.fluentLanguageList!
                                        .remove(item)
                                : isSelected
                                    ? updateProvider.fluentLanguageList!
                                        .remove(item)
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
}
