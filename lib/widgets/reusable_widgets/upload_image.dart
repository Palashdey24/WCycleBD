import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/image_picker_helper.dart';
import 'package:wcycle_bd/widgets/loading_widget.dart';

final imagePickerHelper = ImagePickerHelper();
final firebaseHelper = FirebaseHelper();

class UploadImage extends StatefulWidget {
  const UploadImage(
      {super.key,
      required this.downloadUriFn,
      required this.storageRef,
      this.preImage,
      this.radius});

  final void Function(String uri) downloadUriFn;
  final String storageRef;
  final String? preImage;
  final double? radius;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String? pickOpt;
  File? pickImageFile;
  late Widget imageProvider;
  bool loadImage = false;
  String? uploadUri;

  void _pickImage(String imgOption) async {
    setState(() {
      loadImage = true;
    });
    final imagePicker = ImagePicker();

    final pickFile = await imagePicker.pickImage(
      source: imgOption == "Camera" ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 90,
      /*    maxWidth: 150,
        maxHeight: 150*/
    );

    if (pickFile == null) {
      setState(() {
        loadImage = false;
      });

      return;
    }
    if (!mounted) return;

    Navigator.pop(context);

    setState(() {
      pickImageFile = File(pickFile.path);
    });

    //The below PickedFile are use for web
    PickedFile pfile = PickedFile(pickImageFile!.path);
    uploadUri = await FirebaseHelper.uploadImage(widget.storageRef,
        pickFile.name.split("_").last, pfile, pickImageFile!);

    if (uploadUri != null) {
      //The below line for sent the downloadable uri back to add Recycle item
      widget.downloadUriFn(uploadUri!);

      setState(() {
        loadImage = false;
      });
      imageProvider = Image.file(
        pickImageFile!,
        width: 90,
        height: 90,
        fit: BoxFit.contain,
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        imagePickerHelper.showImgPickOptDia(
          context,
          (pickOption) {
            _pickImage(pickOption);
          },
        );
      },
      child: loadImage
          ? CircleAvatar(
              maxRadius: widget.radius ?? 70,
              child: const LoadingWidgets(),
            )
          : Card(
              shape: const CircleBorder(),
              color: Colors.black26,
              clipBehavior: Clip.hardEdge,
              child: uploadUri == null
                  ? widget.preImage == null
                      ? Image.asset(
                          "assets/upload-avater.png",
                          width: 100,
                          height: 100,
                        )
                      : Image.network(
                          widget.preImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                  : imageProvider,
            ),
    );
  }
}
