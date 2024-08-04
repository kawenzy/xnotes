import 'dart:async';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xenotes/components/editor.dart';
import 'dart:io';

import 'package:xenotes/func/sde.dart';

class VImg extends StatefulWidget {
  final String img;
  const VImg({super.key, required this.img});

  @override
  State<VImg> createState() => _VImgState();
}

class _VImgState extends State<VImg> {
  Stream<String>? filepath;
  StreamController<String> sStream = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    filepath = getPath(widget.img);
  }

  Future<void> getFilePath(String fileName) async {
    final paths = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM);
    final List<FileSystemEntity> files = await Directory('$paths/xenotes')
        .list(recursive: true, followLinks: true)
        .toList();
    for (var file in files) {
      if (file.path.split('/').last == fileName) {
        final s = file.path;
        sStream.add(s);
      }
    }
  }

  Stream<String> getPath(String na){
    getFilePath(na);
    return sStream.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 0, 0, 0),
        child: StreamBuilder<String>(
          stream: filepath,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(),
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    ShareImage(url: snapshot.data!).shares();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        "Share",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // DeleteImage(path: snapshot.data!).delete();
                    AsImage.delete(snapshot.data!);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        "Delete",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editor(path: snapshot.data!),
                        ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        "Editing",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.img,
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      body: SafeArea(
          child: StreamBuilder<String>(
              stream: filepath,
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SizedBox());
                }
                return Center(
                  child: SingleChildScrollView(
                    child: Image.file(File(snapshot.data!)),
                  ),
                );
              })),
    );
  }
}
