import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';

final dialogHelper = DialogsHelper();

class FirebaseHelper {
  static final firebaseAuth = FirebaseAuth.instance;
  static final fireStore = FirebaseFirestore.instance;

  static final userId = firebaseAuth.currentUser!.uid;

  //Only for camera and gallery image
  static Future<String> uploadImage(String folder, String subFolder,
      PickedFile pickImgFile, File pickfile) async {
    final extension = subFolder.split(".").last;
    Reference storageRefImg =
        FirebaseStorage.instance.ref().child(folder).child(subFolder);

    await storageRefImg.putData(await pickImgFile.readAsBytes(),
        SettableMetadata(contentType: 'image/$extension'));
    String uploadUri = await storageRefImg.getDownloadURL();
    return uploadUri;
  }

//This is for Upload file like image,pdf etc
  static Future<String?> uploadFile(
      BuildContext context,
      String folder,
      String typeFolder,
      String fileName,
      File pickfile,
      bool isProgressStop) async {
    final extension = fileName.split(".").last;
    final content = extension == "pdf" ? 'application/pdf' : 'image/$extension';
    final storageReffile = FirebaseStorage.instance
        .ref()
        .child(folder)
        .child(typeFolder)
        .child(fileName);

    UploadTask uploadTask =
        storageReffile.putFile(pickfile, SettableMetadata(contentType: content))
          ..catchError((error) {
            if (!context.mounted) {
              return null;
            }
            DialogsHelper.showMessage(
                context, "Upload file Faild: ${error.message}");
            if (isProgressStop) {
              Navigator.pop(context);
            }

            return null;
          });

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String?> upFirestoreDataWithID(
      Map<String, dynamic> firestoreData,
      BuildContext context,
      DocumentReference<Map<String, dynamic>> ref) async {
    DialogsHelper.showProgressBar(context);

    try {
      await ref.set(firestoreData).then(
        (value) {
          if (context.mounted) {
            Navigator.pop(context);
            DialogsHelper.showMessage(context, "Added Successfully");
            return value;
          }
        },
      );

      return "Data added";
    } on FirebaseException catch (error) {
      if (!context.mounted) return null;

      Navigator.pop(context);
      DialogsHelper.showMessage(context, "Something Wrong: ${error.message}");
      return null;
    }
  }

  //This is canbe reusable helper for added data on firebase

  static Future<String?> upFirestoreData(Map<String, dynamic> recycleData,
      String fsString, BuildContext context) async {
    DialogsHelper.showProgressBar(context);
    final reference = fireStore.collection(fsString);

    try {
      final upRecycleData = await reference.add(recycleData).then(
        (value) {
          if (!context.mounted) return null;
          Navigator.pop(context);

          DialogsHelper.showMessage(context, "Added Successfully");
          return value.id;
        },
      );

      return upRecycleData;
    } on FirebaseException catch (error) {
      if (!context.mounted) return null;

      Navigator.pop(context);
      DialogsHelper.showMessage(context, "Something Wrong: ${error.message}");
      return null;
    }
  }
}
