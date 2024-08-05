import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Xnote",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("information for my app", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),),
              SizedBox(
                height: 10,
              ),
              Text("doubleTap: delete field for note", style: GoogleFonts.poppins(color: Colors.white),),
              SizedBox(
                height: 10,
              ),
              Text("oneTap: change value field for note", style: GoogleFonts.poppins(color: Colors.white),),
              SizedBox(
                height: 10,
              ),
              Text("made by kawenzy", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700),),
            ],
          )),
        ),
      ),
    );
  }
}
