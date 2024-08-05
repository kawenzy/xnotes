import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xenotes/func/data_helper.dart';
import 'package:xenotes/page/xnote.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Stream<List<Map<String, dynamic>>>? namedb;
  final TextEditingController crt = TextEditingController();
  @override
  void initState() {
    super.initState();
    searcs();
  }

  void searcs() async { 
    if(crt.text.isNotEmpty){
    final data = DataHelper.searchDataStream(crt.text);
    namedb = data;
    }
    else{
    final datas = DataHelper.getDataStream();
    namedb = datas;
    }
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Search",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 20, 20, 20)),
                child: TextField(
                  readOnly: false,
                  cursorColor: Colors.blueAccent,
                  controller: crt,
                  onChanged: (p0) => searcs(),
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey.shade800),
                  ),
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: namedb,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                    //     child: CircularProgressIndicator(
                    //   color: Colors.white,
                    // )
                    );
                  }
                  final data = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: data.map((datas) {
                      final title = datas["title"];
                      final ids = datas["id"];

                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 20, 20, 20),
                                  ),
                                  height: 70,
                                  // padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        child: Text(
                                          title,
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await DataHelper.delData(ids);
                                            await DataHelper.delFNotes(ids);
                                            final data =
                                                DataHelper.getDataStream();
                                            namedb = data;
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade500,
                                          )),
                                       IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                       Xnote(dbname: title,ids: ids,),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    const begin =
                                                        Offset(0.0, 1.0);
                                                    const end = Offset.zero;
                                                    const curve = Curves.ease;

                                                    var tween = Tween(
                                                            begin: begin,
                                                            end: end)
                                                        .chain(CurveTween(
                                                            curve: curve));

                                                    return SlideTransition(
                                                      position: animation
                                                          .drive(tween),
                                                      child: child,
                                                    );
                                                  },
                                                ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey.shade500,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.orange.shade900,
                                            Colors.purple.shade900
                                          ],
                                          tileMode: TileMode.clamp)),
                                  height: 4,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
