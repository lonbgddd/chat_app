import 'dart:math';

import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/home/binder_page/compnents/photo_item_card.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../config/changedNotify/binder_watch.dart';
import '../../../config/helpers/app_assets.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {Key? key, this.targetUser, this.isDetail, this.isFont, this.onHighlight})
      : super(key: key);
  final UserModel? targetUser;
  final bool? isFont;
  final Function()? isDetail;
  final Function()? onHighlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(children: [
        SizedBox.expand(
            child: isFont! ? buildCard(context) : cardProfile(context)),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildFloatingButton(
                    width: 40,
                    height: 40,
                    padding: 10,
                    icon: SvgPicture.asset(
                      AppAssets.iconLoop,
                      fit: BoxFit.contain,
                    ),
                    colorBg: Colors.transparent,
                    colorBorder: const Color.fromRGBO(243, 214, 119, 1),
                    onTap: () {}),
                buildFloatingButton(
                    width: 55,
                    height: 55,
                    padding: 15,
                    icon: SvgPicture.asset(
                      AppAssets.iconDelete,
                      fit: BoxFit.contain,
                      color: Provider.of<BinderWatch>(context).getStatus() ==
                              StatusCard.dislike
                          ? Colors.white
                          : Colors.redAccent,
                    ),
                    colorBg: Provider.of<BinderWatch>(context).getStatus() ==
                            StatusCard.dislike
                        ? Colors.red
                        : Colors.transparent,
                    colorBorder:
                        Provider.of<BinderWatch>(context).getStatus() ==
                                StatusCard.dislike
                            ? Colors.white
                            : Colors.red,
                    onTap: () =>
                        Provider.of<BinderWatch>(context, listen: false)
                            .disLike()),
                buildFloatingButton(
                    width: 40,
                    height: 40,
                    padding: 10,
                    icon: SvgPicture.asset(
                      AppAssets.iconStar,
                      fit: BoxFit.contain,
                    ),
                    colorBg: Colors.transparent,
                    colorBorder: const Color.fromRGBO(98, 186, 243, 1),
                    onTap: () {}),
                buildFloatingButton(
                    width: 55,
                    height: 55,
                    padding: 15,
                    icon: SvgPicture.asset(
                      AppAssets.iconHeart,
                      fit: BoxFit.contain,
                      color: Provider.of<BinderWatch>(context).getStatus() ==
                              StatusCard.like
                          ? Colors.white
                          : Color.fromRGBO(109, 229, 181, 1),
                    ),
                    colorBg: Provider.of<BinderWatch>(context).getStatus() ==
                            StatusCard.like
                        ? const Color.fromRGBO(109, 229, 181, 1)
                        : Colors.transparent,
                    colorBorder:
                        Provider.of<BinderWatch>(context).getStatus() ==
                                StatusCard.like
                            ? Colors.white
                            : const Color.fromRGBO(109, 229, 181, 1),
                    onTap: () => Provider.of<BinderWatch>(context).like()),
                buildFloatingButton(
                  width: 40,
                  height: 40,
                  padding: 10,
                  icon: SvgPicture.asset(
                    AppAssets.iconLightning,
                    fit: BoxFit.contain,
                  ),
                  colorBg: Colors.transparent,
                  colorBorder: const Color.fromRGBO(170, 84, 234, 1),
                  onTap: onHighlight,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
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
          final milliseconds = provider.isDragging ? 0 : 600;

          final center = constraints.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            transform: rotatedMatrix..translate(position.dx, position.dy),
            duration: Duration(milliseconds: milliseconds),
            child: Stack(
              children: [
                cardProfile(context),
                buildStamps(context),
              ],
            ),
          );
        }),
      );

  cardProfile(BuildContext context) => Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(children: [
              PhotoGallery(
                targetUser: targetUser!,
                photoList: targetUser!.photoList,
                isDetail: isDetail,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                isShowInfo: true,
              ),
            ]),
          ),
        ],
      );

  Widget buildFloatingButton(
      {required double width,
      required double height,
      required double padding,
      required SvgPicture icon,
      required Color colorBg,
      required Color colorBorder,
      required onTap}) {
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
