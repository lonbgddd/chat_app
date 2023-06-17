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

  cardProfile() => Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user?.avatar ??
                    'https://thuthuattienich.com/wp-content/uploads/2017/02/anh-dai-dien-facebook-doc-3.jpg'),
                fit: BoxFit.cover,
              )),
          child: Container(),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(1)],
            stops: const [0.6, 1],
          ),
        ),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                  child: Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user!.fullName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    (DateTime.now().year -
                        int.parse(user!.birthday.substring(0, 4)))
                        .toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
               Text(
                user!.biography,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.yellow,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.undo,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bolt,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ],
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
