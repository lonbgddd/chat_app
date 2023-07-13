import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'button_notification.dart';

class ItemNotification extends StatelessWidget {
  final String title;
  final String status;
  final String mess;
  final String time;
  final String imageUrl;
  final String? idUser;
  final String? chatRoomId;
  final String? name;

  const ItemNotification({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.idUser,
    required this.status,
    required this.mess,
    required this.time,
    this.chatRoomId,
    this.name,
  });

  String processDateTime(BuildContext context,String dateTimeStr) {
    DateTime currentDateTime = DateTime.now();

    try {
      DateTime inputDateTime =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").parse(dateTimeStr);
      Duration difference = currentDateTime.difference(inputDateTime);

      if (difference.inDays == 0) {
        return DateFormat("HH:mm:ss")
            .format(inputDateTime); // Trả về giờ nếu trong ngày
      } else if (difference.inDays == 1) {
        return AppLocalizations.of(context).yesterdayText;
      } else {
        return "${difference.inDays} ${AppLocalizations.of(context).yesterdayText}";
      }
    } catch (e) {
      return AppLocalizations.of(context).invalidDateAndTimeErrorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: status == 'false' ? Colors.white54 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl.toString(),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title == "match"
                      ? "${AppLocalizations.of(context).compatibleContent}"
                      : "${AppLocalizations.of(context).sentMessageNotification} $mess}",
                  style:  TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  processDateTime(context,time),
                  style:  TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                ButtonNotification(
                  title: title == 'chat' ? AppLocalizations.of(context).feedbackText : AppLocalizations.of(context).seenText ,
                  idUser: idUser.toString(),
                  chatRoomId: chatRoomId,
                  name: name,
                  avatar: imageUrl,
                  router: title == 'match'
                      ? "home-detail-others-notification"
                      : "detail-message-notification",
                ),
              ],
            ),
          ),
           Icon(
            Icons.camera,
            size: 18,
            color: status == 'false' ? Colors.red : Colors.grey,
          ),
        ],
      ),
    );
  }
}
