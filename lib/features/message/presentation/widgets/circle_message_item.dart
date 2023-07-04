import 'package:chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/helpers/app_assets.dart';
import '../bloc/chat_item/chat_item_bloc.dart';
import '../bloc/detail_message/detail_message_bloc.dart';
import 'detail_message.dart';

class CircleMessageItem extends StatelessWidget {
  const CircleMessageItem(
      {super.key, required this.uid, required this.chatRoomId});

  final String uid;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatItemBloc, ChatItemState>(
      listenWhen: (previous, current) => current is ChatItemActionState,
      buildWhen: (previous, current) => current is! ChatItemActionState,
      listener: (context, state) {
        if (state is ChatItemClicked) {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return BlocProvider<DetailMessageBloc>(
                    create: (context) =>
                    sl()
                      ..add(GetMessageList(uid, chatRoomId!)),
                    child: SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.95,
                        child: DetailMessage(
                          uid: uid,
                          chatRoomId: chatRoomId,
                          name: state.user.fullName,
                          avatar: state.user.avatar,
                          token: state.user.token,
                        )));
              });
          BlocProvider.of<ChatItemBloc>(context)
              .add(GetChatItem(uid!, chatRoomId!));
        }
      },
      builder: (context, state) {
        if (state is ChatItemLoaded) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<ChatItemBloc>(context)
                  .add(ShowDetail(state.user));
            },
            child: SizedBox(
              width: 150,
              height: 120,
              child: Column(
                children: [
                  head(state.user.avatar!,AppAssets.iconStar2,false),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        state.user.fullName ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
  Widget head(String url,String icon, bool isBorder){
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: isBorder ? Border.all(
              color: const Color.fromARGB(229, 238, 181, 27),
              width: 3,
            ): null,
            borderRadius: BorderRadius.circular(10),
          ),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 90,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url), // Đường dẫn tới ảnh
                  fit: BoxFit.fill, // Cách ảnh sẽ được hiển thị trong Container
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image(image: AssetImage(icon),height: 25,width: 25),
        ),
      ],
    );
  }
}
