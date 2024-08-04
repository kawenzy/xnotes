import 'package:flutter/material.dart';
// import 'package:local_shared/local_shared.dart';
// import 'package:xenotes/func/c_n.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:xenotes/page/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await LocalShared('db').initialize();
  await StatusBarControl.setHidden(true, animation:StatusBarAnimation.SLIDE);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // final control = AddDbNote(dbname: 'halo');
  // final controls = AddNotes(dbname: 'halo', type: 'block', content: 'ayam bakar', createdAt: '${DateTime.now()}');
  // final controlr = ReadDbs(dbname: 'halo');
  // final tah = ThumbAdd(imgpath: 'a');
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
