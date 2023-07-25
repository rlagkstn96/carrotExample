import 'dart:typed_data';

import 'package:carrotexample/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageStorage {
  static Future uploadImages(List<Uint8List> images, String itemKey) async {
    var metaData = SettableMetadata(contentType: 'image/jpeg');

    List<String> downloadUrls = [];
    // try {
      for (int i = 0; i < images.length; i++) {
        Reference ref = FirebaseStorage.instance
            .ref('images/$itemKey/$i.jpg');
        if (images.isNotEmpty) await ref.putData(images[i], metaData).catchError((onError){
            logger.e(onError.toString());
        });

        downloadUrls.add(await ref.getDownloadURL());
      }
    // } catch (e) {
    //   logger.e(e);
    // }
    return downloadUrls;
  }
}
