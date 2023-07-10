import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String processDateTime(String dateTimeStr) {
    DateTime currentDateTime = DateTime.now();

    try {
      DateTime inputDateTime =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").parse(dateTimeStr);
      Duration difference = currentDateTime.difference(inputDateTime);

      if (difference.inDays == 0) {
        return DateFormat("HH:mm:ss")
            .format(inputDateTime); // Trả về giờ nếu trong ngày
      } else if (difference.inDays == 1) {
        return "1 ngày trước";
      } else {
        return "${difference.inDays} ngày trước";
      }
    } catch (e) {
      return "Invalid datetime format";
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
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl.toString(),
              width: 60,
              height: 60,
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
                      ? "$name Đã tương hợp với bạn, thành viên đã xác minh. Bắt đầu chào hỏi thoi nào ${processDateTime(time)}"
                      : "$name đã gửi tin nhắn cho bạn: $mess ${processDateTime(time)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                ButtonNotification(
                  title: title == 'chat' ? "Phản hồi" : "Xem",
                  idUser: idUser.toString(),
                  router: title == 'match'
                      ? "home-detail-others-notification"
                      : "detail-message-notification",
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
