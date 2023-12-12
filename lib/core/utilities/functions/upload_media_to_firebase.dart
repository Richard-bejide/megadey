import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:megadey_mobile/core/utilities/functions/toast.dart';

import '../../enums/toast_type.dart';

Future<String?> uploadMediaToStorage(BuildContext context, String filePath,
    {required String reference}) async {
  try {
    String? downLoadUrl;

    final String fileName =
        '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}';

    final Reference firebaseStorageRef = FirebaseStorage.instance.ref(reference).child(fileName);

    print('Firebase Storage Reference: $firebaseStorageRef');

    final UploadTask uploadTask = firebaseStorageRef.putFile(File(filePath));

    await uploadTask.whenComplete(() async {
      print("Media Uploaded");
      downLoadUrl = await firebaseStorageRef.getDownloadURL();
      print("Download Url: $downLoadUrl}");
    });

    return downLoadUrl!;
  } catch (e) {
    print("Error: Firebase Storage Exception is: ${e.toString()}");
    showToast(context: context, message: '${e.toString()}', messageType: ToastMessageType.error);
    return null;
  }
}
