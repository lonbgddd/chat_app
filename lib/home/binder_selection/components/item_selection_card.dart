import 'package:chat_app/config/changedNotify/liked_user_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
class ItemSelectionCard extends StatelessWidget {
  const ItemSelectionCard({
    Key? key,
    this.user,
    this.isDetail, required this.onTap,
  }) : super(key: key);

  final UserModel? user;
  final Function()? isDetail;
  final Function() onTap;



  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime endOfDay =
        DateTime(now.year, now.month, now.day).add(Duration(days: 1));

    Duration remainingTime = endOfDay.difference(now);
    int remainingHours = (remainingTime.inHours) + 1;
    int remainingMinutes = remainingTime.inMinutes + 1;

    return SizedBox.expand(
        child: cardProfile(context,
            remainingHours: remainingHours,
            remainingMinutes: remainingMinutes));
  }

  Widget cardProfile(context,
      {required int remainingHours, required int remainingMinutes}) {
    return GestureDetector(
      onTap: isDetail,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(user!.avatar ),
                  fit: BoxFit.cover,
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
                  stops: const [0.5, 1],
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '${user?.fullName}, ${DateTime.now().year - int.parse(user!.birthday.substring(0, 4))}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          (user?.fullName.length ?? 0) > 10
                                              ? 13
                                              : 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                remainingHours == 1
                                    ? 'Còn lại $remainingMinutes phút'
                                    : 'Còn lại $remainingHours giờ',
                                style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(AppAssets.iconHeart, color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
