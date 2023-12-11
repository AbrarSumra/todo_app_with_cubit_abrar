import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_note_abrar/AppDataBase/app_db.dart';
import 'package:todo_note_abrar/Cubit/note_state.dart';
import 'package:todo_note_abrar/Model/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit({required this.appDB}) : super(InitialState());

  AppDataBase appDB;

  /// Add Note
  void addNote(NoteModel newNote) async {
    emit(LoadingState());
    var check = await appDB.addNote(newNote);
    if (check) {
      List<NoteModel> arrNotes = await appDB.fetchNotes();
      emit(LoadedState(mData: arrNotes));
    } else {
      emit(ErrorState(errorMsg: "Note not Added!!!"));
    }
  }

  void getAllNotes() async {
    emit(LoadingState());

    List<NoteModel> arrNotes = await appDB.fetchNotes();
    emit(LoadedState(mData: arrNotes));
  }
}
