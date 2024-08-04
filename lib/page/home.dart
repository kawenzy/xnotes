import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xenotes/func/data_helper.dart';
import 'package:xenotes/page/about.dart';
import 'package:xenotes/page/camera.dart';
import 'package:xenotes/page/search.dart';
import 'package:xenotes/page/xnote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<List<Map<String, dynamic>>>? namedb;
  @override
  void initState() {
    super.initState();
    final data = DataHelper.getDataStream();
    namedb = data;
  }


  Future<void> inps() async {
    await DataHelper.createData("untitled");
    final data = DataHelper.getDataStream();
    namedb = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Xenotes",
          style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 25),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Camera(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ))
                  },
              icon:
                  Icon(Icons.camera_alt_outlined, color: Colors.grey.shade200)),
          IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const About(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ))
                  },
              icon: Icon(Icons.info_outline, color: Colors.grey.shade200)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: FittedBox(fit: BoxFit.cover,child: Image.asset("assets/xnt.gif")))),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 20, 20, 20)),
                child: TextField(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Search(),
                        ))
                  },
                  readOnly: true,
                  cursorColor: Colors.blueAccent,
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
                  final data = snapshot.data!.take(4);
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
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: inps,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: const Color.fromARGB(255, 20, 20, 20),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.redAccent,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
