import 'package:chat_app/features/message/domain/entities/chat_message_entity.dart';
import 'package:chat_app/features/message/presentation/bloc/chat_item/chat_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyItemMessage extends StatelessWidget {
  final String? uid;
  final String? chatRoomId;

  const MyItemMessage({super.key, this.uid, this.chatRoomId});

  Future<void> getTime() async {
    DateTime currentTime = await NTP.now(
    );
    print('Thời gian từ NTP: $currentTime');
  }
  @override
  Widget build(BuildContext context) {
    getTime();
    return BlocConsumer<ChatItemBloc, ChatItemState>(
      listenWhen: (previous, current) => current is ChatItemActionState,
      buildWhen: (previous, current) => current is! ChatItemActionState,
      listener: (context, state) {
        if (state is ChatItemClicked) {
          context.goNamed('detail-message', queryParameters: {
            'uid': uid,
            'chatRoomId': chatRoomId,
            'name': state.user.fullName,
            'avatar': state.user.avatar,
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
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 20, bottom: 20),
              width: 70,
              height: 70,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(state.user.avatar ?? ""),
                    child: state.user.activeStatus == "online"
                        ? Stack(children: [
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.green,
                                  ),
                                )),
                          ])
                        : null,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: StreamBuilder<ChatMessageEntity>(
                          stream: state.lastMessageStream,
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.user.fullName ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      snapshot.hasData ? Text(
                                              snapshot.data!.messageText  != '' ? snapshot.data!.messageText! : AppLocalizations.of(context).messageScreenSentImageText,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(AppLocalizations.of(context)!.messageScreenNoMessage,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade500,
                                                  fontStyle: FontStyle.italic),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                    ],
                                  ),
                                ),
                                snapshot.hasData
                                    ? snapshot.data!.uid != uid
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.black,
                                            ),
                                            child:  Text(
                                              AppLocalizations.of(context).messageScreenYourTurnText,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                        : const Text('')
                                    : const Text('')
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
