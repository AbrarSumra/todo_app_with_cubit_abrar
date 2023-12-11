import 'package:todo_note_abrar/AppDataBase/app_db.dart';

class NoteModel {
  NoteModel({
    required this.user_id,
    required this.note_Id,
    required this.note_Title,
    required this.note_Desc,
  });

  int user_id;
  int note_Id;
  String note_Title;
  String note_Desc;

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      user_id: map[AppDataBase.COLUMN_USER_ID],
      note_Id: map[AppDataBase.COLUMN_NOTE_ID],
      note_Title: map[AppDataBase.COLUMN_NOTE_TITLE],
      note_Desc: map[AppDataBase.COLUMN_NOTE_DESC],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.COLUMN_USER_ID: user_id,
      AppDataBase.COLUMN_NOTE_TITLE: note_Title,
      AppDataBase.COLUMN_NOTE_DESC: note_Desc,
    };
  }
}
