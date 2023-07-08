import 'dart:ui';
import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/highlight_user_watch.dart';
import 'compnents/indicator_highlight_page.dart';


class HighlightScreen extends StatefulWidget {
  final String? currentUserID;
  final String? targetUserID;
  const HighlightScreen({Key? key, this.currentUserID,this.targetUserID}) : super(key: key);

  @override
  State<HighlightScreen> createState() => _HighlightScreenScreenState();
}

class _HighlightScreenScreenState extends State<HighlightScreen> {
  List<String> appbarTitleList = ['','Phổ biến','Giá trị nhất'];
  List<String> priceList = ['150.000','300.000','500.000'];
  List<String> titleList = ['Tăng tốc 10 phút','Tăng tốc 20 phút','Tăng tốc 30 phút'];
  List<int> timeList = [5,10,15];
  var _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    print('CurrentUserID: ${widget.currentUserID} -  TargetUserID: ${widget.targetUserID} ');
    Provider.of<ProfileWatch>(context, listen: false).getUser();
    Provider.of<ProfileWatch>(context, listen: false).getTargetUserUser(widget.targetUserID);
  }


  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBody: true,
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: padding.top),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 15),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(AppAssets.iconDelete, width: 20, colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Trở nên nổi bật', style: TextStyle(color: Colors.black, fontSize: 23,fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
                    const SizedBox(height: 10,),
                    Text('Đẩy hồ sơ của bạn lên top đầu để tăng khả năng tương hợp với "người kia"!', style: TextStyle(color: Colors.black, fontSize: 15,), textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.76),
                  onPageChanged: (index){
                    setState(() {
                      _selectedIndex = index;
                    });

                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: priceList.length,
                  itemBuilder: (context, index){
                    var _scale = _selectedIndex == index ? 1.0 : 0.8;

                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 350),
                      tween: Tween(begin: _scale, end: _scale),
                      curve: Curves.ease,
                      child: buildItemPageView(appbarTitleList[index].toUpperCase(),titleList[index].toUpperCase(),priceList[index],timeList[index]),
                      builder: (context,value, child){
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                    );
                  }
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(priceList.length, (index) => Indicator(isActive: _selectedIndex == index ? true : false)),
                ],
              ),
              Expanded(
                flex: 5,
                  child: Container()
              )

            ],
          ),

        ),
      
    );
  }

  Widget buildItemPageView(String titleAppBar, String title,String price, int time){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: titleAppBar.isEmpty ? Colors.white : Color.fromRGBO(251, 233, 255,1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            ),
            child: Text(titleAppBar ?? '', style: TextStyle(color: Color.fromRGBO(178, 27, 240,1),fontSize: 16,fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 15,),
          Text(title, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600)),
          const SizedBox(height: 10,),
          Text('$price đ/lượt', style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600)),
          const SizedBox(height: 35,),
          InkWell(
            onTap: (){
              Provider.of<HighlightUserNotify>(context, listen: false).startHighlight(context.read<ProfileWatch>().currentUser, context.read<ProfileWatch>().targetUser,time);
              showDialogConfirm(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 55,vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [const Color.fromRGBO(180, 47, 248,1), const Color.fromRGBO(236, 119, 249, 1)],
                ),
              ),
              child: Text('Chọn', style: TextStyle(fontSize: 18, color:  Colors.white ,fontWeight: FontWeight.w600),),
              ),
          ),
        ],
      ),
    );
  }
  showDialogConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.iconTinder,
                  width: 55,
                  height: 55,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text('Đã hoàn tất nổi bật, mong bạn sớm tìm được một nửa cuộc đời mình!', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor:  Color.fromRGBO(234, 64, 128, 1),
                      ),
                      child: Text(
                        'Tôi đã rõ', style: TextStyle(fontSize: 19, color: Colors
                          .white, fontWeight: FontWeight.w600),)),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}



