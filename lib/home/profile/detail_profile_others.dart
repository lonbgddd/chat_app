import 'dart:ui';

import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/binder_watch.dart';
import '../../config/helpers/helpers_user_and_validators.dart';
import '../binder_page/compnents/photo_item_card.dart';

class DetailProfileOthersScreen extends StatefulWidget {
  final String? uid;
  const DetailProfileOthersScreen({Key? key, this.uid}) : super(key: key);

  @override
  State<DetailProfileOthersScreen> createState() => _DetailProfileOthersScreenState();
}

class _DetailProfileOthersScreenState extends State<DetailProfileOthersScreen> {
  int tappedButtonIndex = -1;

  Future<void> _handleTap(int buttonIndex,Function() onTap) async {
    setState(() {
      tappedButtonIndex = buttonIndex;
    });

    await Future.delayed(Duration(milliseconds: 100));

    setState(() {
      tappedButtonIndex = -1;
    });

    onTap();

  }


  @override
  void initState() {
    super.initState();
    Provider.of<ProfileWatch>(context, listen: false).getUser();
  }
  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
        body: FutureBuilder<UserModel>(
            future: context.read<ProfileWatch>().getDetailOthers(widget.uid),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: padding.top, bottom: 150),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 1.47,
                            child: Stack(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height / 1.55,
                                    child: PhotoGallery(targetUser: snapshot.data!,photoList: snapshot.data!.photoList,scrollPhysics: AlwaysScrollableScrollPhysics(),isShowInfo: false,)
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 20,
                                    child: GestureDetector(
                                      onTap:  () => Navigator.pop(context),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [const Color.fromRGBO(234, 64, 128, 1), const Color.fromRGBO(238, 128, 95, 1)],
                                          ),
                                        ),
                                        child:  Image.asset(AppAssets.iconArrowDown),
                                      ),
                                    )
                                ),
                                //
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.fullName.length > 13 ?
                                      snapshot.data!.fullName.substring(0,13)+'...':   snapshot.data!.fullName ?? '',
                                      style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,),
                                    const SizedBox(width: 8),
                                    Text((DateTime.now().year -
                                          int.parse(snapshot.data!.birthday.substring(0, 4)))
                                          .toString(),
                                      style:  TextStyle(
                                          color: Colors.black54,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),

                              ],
                            ),
                          ),

                          (snapshot.data!.introduceYourself!.isNotEmpty || snapshot.data!.datingPurpose!.isNotEmpty) ? Container(
                            width: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (snapshot.data!.datingPurpose!.isNotEmpty) ?
                                     buildDatingPurposeBox(snapshot.data!.datingPurpose) : SizedBox.shrink(),

                                (snapshot.data!.introduceYourself!.isNotEmpty) ?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 25,),
                                        Text('Giới thiệu bản thân', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                                        const SizedBox(height: 10),
                                        Text(snapshot.data!.introduceYourself.toString(), style: TextStyle(color: Colors.black54,fontSize: 16,),textAlign: TextAlign.start,),
                                      ],
                                    ): SizedBox.shrink(),

                              ],
                            ),
                          ): SizedBox.shrink(),

                          (snapshot.data!.interestsList.length > 0) ? Container(
                            width: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sở thích', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child:Wrap(
                                    spacing: BorderSide.strokeAlignCenter,
                                    children: List.generate(snapshot.data!.interestsList.length , (rowIndex) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 5,right: 8),
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey
                                          ),
                                        ),
                                        child: Text(snapshot.data!.interestsList[rowIndex].toString(), style: TextStyle(color: Colors.black54,fontSize: 15,),textAlign: TextAlign.start,),
                                      );

                                    },
                                    ),


                                  ),
                                ),

                              ],
                            ),
                          ): SizedBox.shrink(),
                          const SizedBox(height: 30),
                          buildFunctionButton(title:'Chia sẻ hồ sơ',content: 'Xem bạn nghĩ gì',onTap: (){} ),
                          buildFunctionButton(title:'Chặn ${snapshot.data?.fullName}',content: 'Bạn sẽ không thấy họ, và học sẽ không thấy bạn',onTap: (){} ),
                          buildFunctionButton(title:'Báo cáo ${snapshot.data?.fullName}',content:'Đừng lo lắng - chúng tôi sẽ không thông báo cho người này',onTap: (){} ),
                        ],
                      ),
                    ),

                  )
                  : Container();
            }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(bottom: 15),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildFloatingButton(55,55,15,AppAssets.iconDelete,(){
                Navigator.pop(context);
                Provider.of<BinderWatch>(context, listen: false).disLike();
              },0),
              const SizedBox(width: 20),
              buildFloatingButton(40,40,10,AppAssets.iconStar,(){},1),
              const SizedBox(width: 20),
              buildFloatingButton(55,55,10,AppAssets.iconHeart,(){
                Navigator.pop(context);
                Provider.of<BinderWatch>(context, listen: false).like();
              },2),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildFloatingButton(double width,double height,double padding, String icon,Function() onTap, int index) {
    return GestureDetector(
          onTap: (){
            _handleTap(index,onTap);
          },
          child: AnimatedContainer(
              width: width,
              height: height,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(tappedButtonIndex == index ? 0.9 : 1.0),
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset(icon, fit: BoxFit.contain,
              ),
          ),
      );
  }


  Widget buildFunctionButton({required String title, required String content,onTap}) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
              width: 0.8,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 0.8,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w500),),
            const SizedBox(height: 5),
            Text(content, style: TextStyle(color: Colors.black54,fontSize: 16,),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }


  Widget buildDatingPurposeBox(String title) {
    int index = HelpersUserAndValidators.datingPurposeList.indexWhere((item) => item == title);
    return Container(
        width: MediaQuery.of(context).size.width / 1.4,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color:(index != -1) ? HelpersUserAndValidators.colorBgPurposeList[index] : Colors.white,
            borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (index != -1)  ? Image.asset(HelpersUserAndValidators.emojiDatingPurposeList[index],width: 30,height: 30,): SizedBox.shrink(),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mình đang tìm', style: TextStyle(color:(index != -1) ? HelpersUserAndValidators.colorTitlePurposeList[index] : Colors.white ,fontSize: 15,fontWeight: FontWeight.w500),),
              Text(title, style: TextStyle(color: (index != -1) ? HelpersUserAndValidators.colorTitlePurposeList[index] : Colors.white ,fontSize: 17,fontWeight: FontWeight.w600),),
            ],
          )
        ],
        )
    );
  }
}
