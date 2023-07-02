import 'dart:math';

import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/home/binder_page/compnents/photo_item_card.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, this.user, this.isDetail, this.isFont})
      : super(key: key);
  final UserModel? user;
  final bool? isFont;
  final Function()? isDetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: isFont! ? buildCard(context) : cardProfile(context));
  }

  Widget buildCard(context) => GestureDetector(
        onPanStart: (details) {
          final provider = Provider.of<BinderWatch>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<BinderWatch>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<BinderWatch>(context, listen: false);
          provider.endPosition();
        },
        child: LayoutBuilder(builder: (context, constraints) {
          final provider = Provider.of<BinderWatch>(context);
          final position = provider.position;
          final minilis = provider.isDragging ? 0 : 400;
          final center = constraints.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            transform: rotatedMatrix..translate(position.dx, position.dy),
            duration: Duration(microseconds: minilis),
            child: Stack(
              children: [cardProfile(context), buildStamps(context)],
            ),
          );
        }),
      );

  cardProfile(BuildContext context) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: (user!.photoList.length != 0)
                  ? PhotoGallery(
                      photoList: user!.photoList,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user?.avatar ??
                              'https://thuthuattienich.com/wp-content/uploads/2017/02/anh-dai-dien-facebook-doc-3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(1)],
                  stops: const [0.25, 1],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (user!.activeStatus.toString().contains('online'))
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            109, 229, 181, 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 10),
                                        child: Text(
                                          'Đang hoạt động',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      user!.fullName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      (DateTime.now().year -
                                              int.parse(user!.birthday
                                                  .substring(0, 4)))
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                user?.introduceYourself ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: isDetail,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildFloatingButton(
                            40,
                            40,
                            10,
                            SvgPicture.asset(
                              AppAssets.iconLoop,
                              fit: BoxFit.contain,
                            ),
                            Colors.transparent,
                            const Color.fromRGBO(243, 214, 119, 1),
                            () {}),
                        buildFloatingButton(
                            55,
                            55,
                            15,
                            SvgPicture.asset(
                              AppAssets.iconDelete,
                              fit: BoxFit.contain,
                              color: Provider.of<BinderWatch>(context)
                                          .getStatus() ==
                                      StatusCard.dislike
                                  ? Colors.white
                                  : Colors.redAccent,
                            ),
                            Provider.of<BinderWatch>(context).getStatus() ==
                                    StatusCard.dislike
                                ? Colors.red
                                : Colors.transparent,
                            Provider.of<BinderWatch>(context).getStatus() ==
                                    StatusCard.dislike
                                ? Colors.white
                                : Colors.red,
                            () =>
                                Provider.of<BinderWatch>(context, listen: false)
                                    .disLike()),
                        buildFloatingButton(
                            40,
                            40,
                            10,
                            SvgPicture.asset(
                              AppAssets.iconStar,
                              fit: BoxFit.contain,
                            ),
                            Colors.transparent,
                            const Color.fromRGBO(98, 186, 243, 1),
                            () {}),
                        buildFloatingButton(
                            55,
                            55,
                            15,
                            SvgPicture.asset(
                              AppAssets.iconHeart,
                              fit: BoxFit.contain,
                              color: Provider.of<BinderWatch>(context)
                                          .getStatus() ==
                                      StatusCard.like
                                  ? Colors.white
                                  : const Color.fromRGBO(109, 229, 181, 1),
                            ),
                            Provider.of<BinderWatch>(context).getStatus() ==
                                    StatusCard.like
                                ? const Color.fromRGBO(109, 229, 181, 1)
                                : Colors.transparent,
                            Provider.of<BinderWatch>(context).getStatus() ==
                                    StatusCard.like
                                ? Colors.white
                                : const Color.fromRGBO(109, 229, 181, 1),
                            () => Provider.of<BinderWatch>(context).like()),
                        buildFloatingButton(
                            40,
                            40,
                            10,
                            SvgPicture.asset(
                              AppAssets.iconLightning,
                              fit: BoxFit.contain,
                            ),
                            Colors.transparent,
                            const Color.fromRGBO(170, 84, 234, 1),
                            () {}),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget buildFloatingButton(double width, double height, double padding,
      SvgPicture icon, Color colorBg, Color colorBorder, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: colorBg,
          shape: BoxShape.circle,
          border: Border.all(
            color: colorBorder,
            width: 1.5,
          ),
        ),
        child: icon,
      ),
    );
  }

// animation card left or right
  Widget buildStamps(context) {
    final provider = Provider.of<BinderWatch>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();
    switch (status) {
      case StatusCard.like:
        final child = buildStamp(
            angle: -0.5, color: Colors.green, text: "Like", opacity: opacity);
        return Positioned(child: child, top: 64, left: 50);
      case StatusCard.dislike:
        final child = buildStamp(
            angle: 0.5, color: Colors.red, text: "DisLike", opacity: opacity);
        return Positioned(child: child, top: 64, right: 50);
      default:
        return Container();
    }
  }

  buildStamp(
          {double angle = 0,
          required Color color,
          required String text,
          required double opacity}) =>
      Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color, width: 4)),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
}
