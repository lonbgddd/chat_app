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

import '../binder_page/compnents/photo_item_card.dart';

class DetailProfileOthersScreen extends StatefulWidget {
  final String? uid;
  const DetailProfileOthersScreen({Key? key, this.uid}) : super(key: key);

  @override
  State<DetailProfileOthersScreen> createState() => _DetailProfileOthersScreenState();
}

class _DetailProfileOthersScreenState extends State<DetailProfileOthersScreen> {
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
        body: FutureBuilder<UserModal>(
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
                                (snapshot.data!.photoList.length != 0) ? Container(
                                    height: MediaQuery.of(context).size.height / 1.55,
                                    child: PhotoGallery(photoList: snapshot.data!.photoList,scrollPhysics: AlwaysScrollableScrollPhysics(),))
                                    : Container(
                                  height: MediaQuery.of(context).size.height / 1.55,
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data?.avatar ??
                                          'https://thuthuattienich.com/wp-content/uploads/2017/02/anh-dai-dien-facebook-doc-3.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(snapshot.data!.fullName,
                                        style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: Text((DateTime.now().year -
                                            int.parse(snapshot.data!.birthday.substring(0, 4)))
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.blue,),
                                    const SizedBox(width: 5),
                                    Text('Đã xác minh', style: TextStyle(fontSize:16 , color: Colors.blue,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: Colors.grey,),
                                    const SizedBox(width: 5),
                                    Text(snapshot.data!.gender.toString(), style: TextStyle(fontSize:16 , color: Colors.grey,),)
                                  ],
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
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
                                Text('Giới thiệu bản thân', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                                const SizedBox(height: 10),
                                Text(snapshot.data!.introduceYourself.toString(), style: TextStyle(color: Colors.black54,fontSize: 18,),textAlign: TextAlign.start,),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                          Container(
                            width: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
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
                                    children: List.generate(snapshot.data!.interestsList.length , (rowIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 10,  right: 10),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                            ),
                                          ),
                                          child: Text(snapshot.data!.interestsList[rowIndex].toString(), style: TextStyle(color: Colors.black54,fontSize: 17,),textAlign: TextAlign.start,),
                                        ),
                                      );

                                    },
                                    ),


                                  ),
                                ),

                              ],
                            ),
                          ),


                          const SizedBox(height: 30),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              width: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Chia sẻ hồ sơ', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                                  const SizedBox(height: 5),
                                  Text('Xem bạn nghĩ gì', style: TextStyle(color: Colors.black54,fontSize: 16,),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),



                          InkWell(
                            onTap: (){},
                            child: Container(
                              width: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Chặn ${snapshot.data?.fullName}', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                                  const SizedBox(height: 5),
                                  Text('Bạn sẽ không thấy họ, và học sẽ không thấy bạn', style: TextStyle(color: Colors.black54,fontSize: 16,),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              width: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Text('Báo cáo ${snapshot.data?.fullName}', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                                  const SizedBox(height: 5),
                                  Text('Đừng lo lắng - chúng tôi sẽ không thông báo cho người này', style: TextStyle(color: Colors.black54,fontSize: 16,),textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
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
              buildFloatingButton(55,55,15,AppAssets.iconDelete,(){}),
              const SizedBox(width: 20),
              buildFloatingButton(40,40,10,AppAssets.iconStar,(){}),
              const SizedBox(width: 20),
              buildFloatingButton(55,55,10,AppAssets.iconHeart,(){}),
            ],
          ),
        ),
      ),

    );
  }

  Widget buildFloatingButton(double width,double height,double padding, String icon,onTap) {
    return InkWell(
            onTap: onTap,
            child: Container(
              width: width,
              height: height,
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



}
