import 'dart:io';

import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateAvatarScreen extends StatefulWidget {
  const UpdateAvatarScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAvatarScreen> createState() => _UpdateAvatarScreenState();
}

class _UpdateAvatarScreenState extends State<UpdateAvatarScreen> {
  final imagePick = ImagePicker();
  File? imageGallery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UpdateNotify>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: getImageGallery,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                      child: Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          shape: BoxShape.circle,
                        ),
                        child: imageGallery == null
                            ? const Icon(Icons.add)
                            : Image.file(
                                imageGallery!,
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, 0.05),
            child: ElevatedButton(
                onPressed: () async {
                  Provider.of<UpdateNotify>(context, listen: false)
                      .updateImageAvatar(imageGallery);
                },
                child: Text('Save Changeds')),
          )
        ],
      ),
    );
  }

  getImageGallery() async {
    final XFile? image = await imagePick.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageGallery = File(image.path);
      });
    }
  }
}
