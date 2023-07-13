import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateImage extends StatelessWidget {
  const UpdateImage({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    // required this.photoList,
  });

  final double itemWidth;
  final double itemHeight;

  // final List<String> photoList;

  @override
  Widget build(BuildContext context) {
    List<String> photoList = context.watch<UpdateNotify>().photoList!;
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              if (index < photoList.length) {
                return Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.network(
                        photoList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: InkWell(
                      onTap: () => {
                        Provider.of<UpdateNotify>(context, listen: false)
                            .removeImage(photoList[index])
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ]);
              } else {
                return InkWell(
                  onTap: () {
                    Provider.of<UpdateNotify>(context, listen: false)
                        .pickImages();
                  },
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
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    Provider.of<UpdateNotify>(context, listen: false)
                        .pickImages();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20,),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                              colors: [const Color.fromRGBO(234, 64, 128, 1), const Color.fromRGBO(238, 128, 95, 1)],
                          )),
                      child:  Text( AppLocalizations.of(context).buttonAddPhotoText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                  )
              )),
        ],
      ),
    );
  }
}