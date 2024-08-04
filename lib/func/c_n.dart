import 'package:flutter/material.dart';
import 'package:local_shared/local_shared.dart';
import 'package:xenotes/func/s_n.dart';

// typedef DB = LocalShared;
//gak jadi pakek ini

class AddDbNote{
  final DbNote dbNote;
  final String dbname;
  // final skrng = DateTime.now();
  AddDbNote({required this.dbname})
  : dbNote = DbNote(dbname);

  Future<void> AddDb() async {
    await Shared.col('post').doc(dbname).create({});
    await Shared.col(dbname).create();
    debugPrint(dbname);
  }
}

class AddNotes{ 
  final NoteSchema noteSchema;
  final String dbname;
  final String type;
  final String content;
  final String createdAt;
  final String? updatedAt;
  AddNotes({required this.dbname,required this.type, required this.content, required this.createdAt, this.updatedAt})
  : noteSchema = NoteSchema(type, content, createdAt, updatedAt);
  
  Future<void> AddNote() async{
    final rew = await Shared.col(dbname).doc(type).create({
      'type': type,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    });
    print(rew);
  }
}

class ReadDbs{
  final String dbname;
  ReadDbs({required this.dbname});
  Future<void> ReadDb() async{
    final s = await Shared.col(dbname).read().many();
    print(s);
    }
}

class DelNotes{
  final String dbname;
  final String type;
  DelNotes({required this.dbname, required this.type});
  Future<void> DelNote() async {
    await Shared.col(dbname).doc(type).delete();
  }
}

class DelDbNotes{
  final String dbname;
  DelDbNotes({required this.dbname});
  Future<void> DelDbNote() async {
    await Shared.col(dbname).delete();
    }
}

class ThumbAdd{
  final String imgpath;
  ThumbAdd({required this.imgpath});
  Future<void> addThumb() async {
   final s = await Shared.col('t').doc('thumb').create({'t': imgpath});
   if (s.success == false) {
    await Shared.col('t').doc('thumb').update({'t': imgpath});
   }
   print(s);
  }
}