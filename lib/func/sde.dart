import 'dart:async';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:share_plus/share_plus.dart';

class ShareImage {
  final String url;
  ShareImage({required this.url});
  void shares() async {
    await Share.shareXFiles([XFile(url)], text: "xenotes great picture");
  }
}

class AsImage {
  static final StreamController<List<String>> picStream = StreamController<List<String>>.broadcast();
  
  static Future<void> getPhotoNames() async {
    final paths = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    final List<FileSystemEntity> files =
        await Directory('$paths/xenotes')
            .list(recursive: true, followLinks: true)
            .toList();
    final ds = files.map((file) => file.path).toList();
    picStream.add(ds);
  }

  static Stream<List<String>> getPicSt() {
    getPhotoNames();
    return picStream.stream;
  }
  static Future<void> delete(String path) async {
     await Directory(path).delete(recursive: true);
  }
}