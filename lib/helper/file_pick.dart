import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';

final formatter = DateFormat('hh:mm:ss');

class FilePick {
  const FilePick();

  static Future<List<dynamic>?> uploadDoc(
      BuildContext context, List<String> extensions) async {
    DialogsHelper.showProgressBar(context);

    final pickFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: extensions);
    if (!context.mounted) return null;
    if (pickFile == null) {
      Navigator.pop(context);
      DialogsHelper.showMessage(context, "File Not picked");
      return null;
    } else {
      String fileName =
          "${formatter.format(DateTime.now())} ${pickFile.files[0].name}";
      File filePath = File(pickFile.files[0].path!);

      Navigator.pop(context);
      return [fileName, filePath];
    }
  }
}
