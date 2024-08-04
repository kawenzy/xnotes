import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xenotes/components/v_img.dart';
import 'package:xenotes/func/sde.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  Stream<List<String>>? photoNames;

  @override
  void initState() {
    super.initState();
    final s = AsImage.getPicSt();
    photoNames = s;
  }
  

  void getImg(String pathImg) {
    // showBarModalBottomSheet(expand: true,backgroundColor: const Color.fromARGB(255, 8, 8, 8),context: context, builder: (context) => VImg(img: pathImg));
    Navigator.push(context, MaterialPageRoute(builder: (context) => VImg(img: pathImg),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Gallery",
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700, color: const Color.fromARGB(255, 255, 255, 255), fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: StreamBuilder<List<String>>(
            stream: photoNames,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white,));
              } else {
                final names = snapshot.data!;
                return GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    children: names.map((name) {
                      return Stack(
                        children: [
                          Positioned(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.file(
                                            File(name),
                                            filterQuality: FilterQuality.low,
                                          ))))),
                          Positioned(
                              top: 0,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: IconButton(
                                onPressed: () => <void>{
                                  getImg(name.split('/').last)
                                },
                                icon: const Icon(
                                  Icons.expand_less,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                tooltip: "open ${name.split('/').last}",
                              ))
                        ],
                      );
                    }).toList());
                // final im1 = names.last == "82.jpg";
                // return Text(im1.toString());
              }
            },
          ),
        ),
      );
    
  }
}
