import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'indicator_painter.dart';


class PhotoGallery extends StatefulWidget {
  final List<String> photoList;
  ScrollPhysics scrollPhysics;
  final UserModel targetUser;
  final Function()? isDetail;
  bool isShowInfo = false;

  PhotoGallery({required this.targetUser,required  this.photoList, this.isDetail,required this.scrollPhysics,required this.isShowInfo});

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
   PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
      String activeStatus = widget.targetUser!.activeStatus.toString();
      String name = widget.targetUser!.fullName.toString();
      String currentAddress =  widget.targetUser!.currentAddress.toString();
      String school = widget.targetUser!.school.toString();
      String introduceYourself =   widget.targetUser!.introduceYourself.toString();


    return Stack(
      children: [
        PageView.builder(
          physics: widget.scrollPhysics,
          controller: pageController,
          itemCount: widget.photoList.length,
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapUp:  (TapUpDetails details) {
                final double tapPositionX = details.localPosition.dx;
                final double screenWidth = MediaQuery.of(context).size.width;
                final double halfScreenWidth = screenWidth / 2;

                if (tapPositionX < halfScreenWidth && currentIndex > 0) {
                  setState(() {
                    currentIndex--;
                  });
                  pageController.animateToPage(
                    currentIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else if (tapPositionX >= halfScreenWidth &&
                    currentIndex < widget.photoList!.length - 1) {
                  setState(() {
                    currentIndex++;
                  });
                  pageController.animateToPage(
                    currentIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              child: (widget.photoList.length != 0)
                  ?   Container(
                     child: Image.network(widget.photoList[index], fit: BoxFit.cover,)
              )
                  : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://thuthuattienich.com/wp-content/uploads/2017/02/anh-dai-dien-facebook-doc-3.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),


            );
          },
        ),
        (widget.photoList.length > 1) ?
        Positioned(
          top: 5,
          left: 15,
          right: 15,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double indicatorWidth =
                  constraints.maxWidth / widget.photoList!.length;
              return FractionallySizedBox(
                widthFactor: 1,
                child: CustomPaint(
                  painter: IndicatorPainter(
                    itemCount: widget.photoList!.length,
                    currentIndex: currentIndex,
                    indicatorWidth: indicatorWidth,
                  ),
                ),
              );
            },
          ),
        ): SizedBox.shrink(),

        (widget.isShowInfo) ?
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 80),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(1),
                ],
                stops: const [0.0, 0.4, 0.6, 1.0],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (activeStatus.contains('online')&& currentIndex == 0)
                          ? Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(109, 229, 181, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10),
                          child: Text(
                            'Đang hoạt động',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ) : SizedBox.shrink(),

                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            name.length > 15 ?
                            name.substring(0,15)+'...': name ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            (DateTime.now().year -
                                int.parse(widget.targetUser!.birthday!.substring(0, 4)))
                                .toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 5
                      ),
                      (currentAddress.isNotEmpty || school.isNotEmpty && currentIndex == 0) ?
                          Column(
                            children: [
                              (currentAddress.isNotEmpty && currentIndex == 0)
                                ? buildInfo(icon: Icons.home_outlined,content: 'Sống tại ' + HelpersUserAndValidators.extractCity(widget.targetUser!.currentAddress.toString(),',',2))
                                : SizedBox.shrink(),
                              (school.isNotEmpty && currentIndex == 0) ?
                                 buildInfo(icon: Icons.school_outlined,content: school)
                                : SizedBox.shrink(),
                            ],
                          ) : SizedBox.shrink(),

                      (introduceYourself.isNotEmpty && currentIndex == 1)  ?
                        Text(introduceYourself,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ) : SizedBox.shrink(),

                      (widget.targetUser.interestsList.length > 0 && currentIndex == 2)
                          ? generateInterestsList (widget.targetUser.interestsList) : SizedBox.shrink(),

                      (HelpersUserAndValidators.isListNotEmpty(HelpersUserAndValidators.styleOfLifeUserList(widget.targetUser)) && currentIndex == 3)
                          ? generateInterestsList (HelpersUserAndValidators.styleOfLifeUserList(widget.targetUser)) : SizedBox.shrink(),
                    ],
                  ),
                ),
                InkWell(
                  onTap: widget.isDetail,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(AppAssets.iconArrowUp),
                  ),
                )
              ],
            ),
          ),
        ): SizedBox.shrink(),
      ],
    );
  }

  Widget buildInfo({required IconData icon, required String content}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white,size: 20,),
        const SizedBox(width: 5,),
        Text(content,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }


  Widget generateInterestsList (List<String> list){
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int maxRowCount = 2;
            int defaultItemIndex = maxRowCount * 2 - 1;
            int itemCount =list.length;
            return Wrap(
              children: List.generate(itemCount, (index) {
                if (index < defaultItemIndex && list[index].isNotEmpty ) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 3,right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade800,
                    ),
                    child: Text(list[index].toString() ,
                            style: TextStyle(color: Colors.white,fontSize: 13, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,)
                  );
                }else if(index == defaultItemIndex){
                  return InkWell(
                    onTap: widget.isDetail,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3,right: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade800,
                        border: Border.all(
                            width: 1,
                            color: Colors.white
                        ),
                      ),
                      child:
                      Text('Hiển thị thêm', style: TextStyle(color: Colors.white,fontSize: 13, fontWeight: FontWeight.w700),textAlign: TextAlign.start,),
                    ),
                  );
                }else {
                  return SizedBox();
                }

              }).toList(),
            );
          }
      ),
    );
  }


}
