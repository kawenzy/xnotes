class NoteSchema {
  late String type;
  late String content;
  late String createdAt;
  late String? updatedAt;
  NoteSchema(
      this.type,
      this.content,
      this.createdAt,
      this.updatedAt);
}


class DbNote {
  late String dbname;
  DbNote(this.dbname);
}