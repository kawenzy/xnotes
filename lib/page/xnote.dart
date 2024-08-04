import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xenotes/func/data_helper.dart';

class Xnote extends StatefulWidget {
  final String dbname;
  final int ids;
  const Xnote({super.key, required this.dbname, required this.ids});

  @override
  State<Xnote> createState() => _XnoteState();
}

class _XnoteState extends State<Xnote> {
  final TextEditingController crt = TextEditingController();
  Stream<List<Map<String, dynamic>>>? dataNotes;

  @override
  void initState() {
    super.initState();
    crt.text = widget.dbname;
    final ds = DataHelper.getNoteStream(widget.ids);
    dataNotes = ds;
  }

  List<String> type = ["block", "quotes", "default", "divider"];

  void uptitle() async {
    DataHelper.updateData(widget.ids, crt.text);
  }

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
      bottomNavigationBar: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: type.map((t) {
                  return GestureDetector(
                      onTap: () async {
                        await DataHelper.createNote(widget.ids, "__", t);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color.fromARGB(204, 29, 29, 29),
                          ),
                          padding: EdgeInsets.all(4),
                          child: Text(
                            t,
                            style: GoogleFonts.roboto(color: Colors.white),
                          )));
                }).toList()),
          )),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset("assets/xn.gif")))),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent),
                child: TextField(
                  minLines: 1,
                  maxLines: null,
                  readOnly: false,
                  cursorColor: Colors.blueAccent,
                  controller: crt,
                  onChanged: (p0) => uptitle(),
                  toolbarOptions:
                      ToolbarOptions(copy: false, cut: false, paste: false),
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    // icon: Icon(Icons.title),
                    border: InputBorder.none,
                    hintText: "title",
                    hintStyle: TextStyle(color: Colors.grey.shade800),
                  ),
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700),
                ),
              ),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: dataNotes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }
                  final data = snapshot.data!;
                  return Column(
                    children: data.map((e) {
                      Widget? note;
                      final type = e["type"];
                      final isi = e["isi"];
                      final id = e["id"];
                      if (type == "block") {
                        final TextEditingController crt2 =
                            TextEditingController();
                        crt2.text = isi;
                        note = GestureDetector(
                          onDoubleTap: () {
                            DataHelper.delNotes(id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey.shade900),
                            child: TextField(
                              minLines: 1,
                              maxLines: null,
                              onChanged: (p0) =>
                                  {DataHelper.updateNotes(id, crt2.text)},
                              readOnly: false,
                              cursorColor: Colors.blueAccent,
                              controller: crt2,
                              autocorrect: false,
                              autofocus: false,
                              toolbarOptions: ToolbarOptions(
                                  copy: false, cut: false, paste: false),
                              decoration: InputDecoration(
                                // icon: Icon(Icons.title),
                                border: InputBorder.none,
                                // hintText: "title",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade800),
                              ),
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      } else if (type == "default") {
                        final TextEditingController crt2 =
                            TextEditingController();
                        crt2.text = isi;
                        note = GestureDetector(
                          onDoubleTap: () {
                            DataHelper.delNotes(id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.transparent),
                            child: TextField(
                              minLines: 1,
                              maxLines: null,
                              readOnly: false,
                              onChanged: (p0) =>
                                  {DataHelper.updateNotes(id, crt2.text)},
                              cursorColor: Colors.blueAccent,
                              controller: crt2,
                              autocorrect: false,
                              autofocus: false,
                              toolbarOptions: ToolbarOptions(
                                  copy: false, cut: false, paste: false),
                              decoration: InputDecoration(
                                // icon: Icon(Icons.title),
                                border: InputBorder.none,
                                // hintText: "title",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade800),
                              ),
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      } else if (type == "quotes") {
                        final TextEditingController crt2 =
                            TextEditingController();
                        crt2.text = isi;
                        note = GestureDetector(
                          onDoubleTap: () {
                            DataHelper.delNotes(id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.transparent),
                            child: TextField(
                              minLines: 1,
                              onChanged: (p0) =>
                                  {DataHelper.updateNotes(id, crt2.text)},
                              maxLines: null,
                              readOnly: false,
                              cursorColor: Colors.blueAccent,
                              controller: crt2,
                              autocorrect: false,
                              autofocus: false,
                              toolbarOptions: ToolbarOptions(
                                  copy: false, cut: false, paste: false),
                              decoration: InputDecoration(
                                icon: Icon(Icons.format_quote_outlined),
                                border: InputBorder.none,
                                // hintText: "title",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade800),
                              ),
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      } else if (type == "divider") {
                        note = GestureDetector(
                          onDoubleTap: () {
                            DataHelper.delNotes(id);
                          },
                          child: Container(
                            height: 2,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: Colors.grey.shade900),
                          ),
                        );
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: note,
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
