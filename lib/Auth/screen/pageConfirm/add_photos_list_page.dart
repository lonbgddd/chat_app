import 'package:chat_app/Auth/widget/button_submit_page_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/helpers_user_and_validators.dart';

class AddPhotoListPageSection extends StatelessWidget {
  const AddPhotoListPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 210) / 2;
    final double itemWidth = size.width / 2;
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: ()  {
                      pageProvider.previousPage();
                    },
                    icon: Icon(Icons.west, color: Colors.grey, size: 30,),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Add recent photos of yourself',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text('Upload 2 photos to start finding like-minded people. Adding more photos will make your profile stand out.',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < pageProvider.imageCount) {
                          return Container(
                            child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Image.file(
                                        pageProvider.photosList[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () => pageProvider.isEditingPhoto ? pageProvider.removeImageFromList(index) : pageProvider.pickImages(),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey,width: 1),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(pageProvider.isEditingPhoto ? Icons.close_rounded : Icons.edit , color: Colors.grey,size: 20,),

                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: pageProvider.pickImages,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: DottedBorder(
                                strokeWidth: 3,
                                borderType: BorderType.RRect,
                                color: Colors.grey.shade500,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Icon(Icons.add, size: 30,),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            ButtonSubmitPageView(text: 'Finish',marginBottom: 70,
                color: pageProvider.imageCount >= 2 ? Colors.transparent : Colors.grey,
                onPressed: () {
                  pageProvider.imageCount >= 2 ? pageProvider.confirmUser(context) : null;
                }),
          ],
        ),
      ),
    );
  }
}
