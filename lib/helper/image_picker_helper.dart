

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/image_picker_helper_option.dart';

final fontHelper = FontHelper();

class ImagePickerHelper {
  final imagePicker = ImagePicker();
  String? pickOpts;

  void showImgPickOptDia(
      BuildContext context, void Function(String pickOpt) onPickFn) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: 400,
            height: 400,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.elliptical(30, 30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please Pick Image from Gallery",
                  textAlign: TextAlign.center,
                  style: fontHelper.bodyLarge(context).copyWith(
                        color: Colors.green,
                      ),
                ),
                const Gap(largeGap + 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => onPickFn("Camera"),
                      child: const ImagePickerHelperOption(
                          faIcons: FontAwesomeIcons.cameraRetro,
                          colos: Color.fromARGB(202, 198, 207, 11),
                          optiontxt: "Camera"),
                    ),
                    const Gap(largeGap),
                    GestureDetector(
                      onTap: () => onPickFn("Gallery"),
                      child: const ImagePickerHelperOption(
                          faIcons: FontAwesomeIcons.cameraRetro,
                          colos: Color.fromARGB(226, 8, 30, 28),
                          optiontxt: "Gallery"),
                    ),
                  ],
                ),
                const Gap(largeGap),
                ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    label: Text(
                      "Cancel",
                      style: fontHelper.bodyMedium(context),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
