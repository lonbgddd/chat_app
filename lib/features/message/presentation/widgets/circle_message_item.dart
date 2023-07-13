import 'package:chat_app/features/message/domain/entities/chat_room_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/helpers/app_assets.dart';
import '../bloc/chat_item/chat_item_bloc.dart';

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
          context.goNamed('detail-message',queryParameters: {
            'uid': uid,
            'chatRoomId':chatRoomId,
            'name': state.user.fullName,
            'avatar': state.user.avatar,
            'token': state.user.token
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
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  newChatRoom(state.user.avatar!, AppAssets.iconStar2, state.isNewChatRoom),
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

  Widget newChatRoom(String url, String icon, bool isNew) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 90,
              height: 123,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url), // Đường dẫn tới ảnh
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
          child: Image(image: AssetImage(icon), height: 25, width: 25),
        ),
        isNew == true
            ? Positioned(
                bottom: 0,
                right: 0,
                top: 0,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ))
            : Container()
      ],
    );
  }
}
