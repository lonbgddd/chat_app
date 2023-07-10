import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'basic_information_bottom_sheet.dart';

class BasicInformationRow extends StatelessWidget {
  const BasicInformationRow({
    super.key,
    required this.title,
    this.content,
    required this.icon,
    required this.updateProvider,
  });

  final String title;
  final String? content;
  final String icon;
  final UpdateNotify updateProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromRGBO(229, 58, 69, 100),
      onTap: () {
        showModalBottomSheet(
          showDragHandle: true,
          isScrollControlled: true,
          isDismissible: true,
          useSafeArea: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: context,
          builder: (context) {
            return const BasicInformationBottomSheet();
          },
        ).whenComplete(() => updateProvider.getUser(false));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              width: MediaQuery.of(context).size.width / 2 - 8.0,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                      height: 20,
                      child: SvgPicture.asset(icon)),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 8.0,
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      content!.isNotEmpty ? content! : "Trống",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade700,
                    size: 12,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}