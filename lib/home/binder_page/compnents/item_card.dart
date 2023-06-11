import 'dart:math';

import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, this.user, this.isFont}) : super(key: key);
  final User? user;
  final bool? isFont;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: isFont! ? buildCard(context) : cardProfile());
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
              children: [cardProfile(), buildStamps(context)],
            ),
          );
        }),
      );

  cardProfile() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(user?.avatar ??
                'https://thuthuattienich.com/wp-content/uploads/2017/02/anh-dai-dien-facebook-doc-3.jpg'),
            fit: BoxFit.cover,
          )),
          child: Container(),
        ),
      );

  Widget buildStamps(context) {
    final provider = Provider.of<BinderWatch>(context);
    final status = provider.getStatus();
    switch (status) {
      case StatusCard.like:
        final child =
            buildStamp(angle: -0.5, color: Colors.green, text: "Like");
        return Positioned(child: child, top: 64, left: 50);
      case StatusCard.dislike:
        final child =
            buildStamp(angle: 0.5, color: Colors.green, text: "DisLike");
        return Positioned(child: child, top: 64, right: 50);
      default:
        return Container();
    }
  }

  buildStamp({double angle = 0, required Color color, required String text}) =>
      Transform.rotate(
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
      );
}
