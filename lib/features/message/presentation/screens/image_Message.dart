// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:photo_view/photo_view.dart';
//
// class ImageMessage extends StatelessWidget {
//   String? url;
//
//   ImageMessage({required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.west,
//               color: Colors.grey,
//               size: 30,
//             ),
//             onPressed: () {
//               context.pop();
//             },
//           ),
//         ),
//         body: PhotoView(
//           imageProvider: NetworkImage(url!),
//           minScale: PhotoViewComputedScale.contained* 0.8,
//           maxScale: PhotoViewComputedScale.contained * 2.0,
//           initialScale: PhotoViewComputedScale.contained,
//         ));
//   }
// }
