import '../Model/note_model.dart';

abstract class NoteState {}

class InitialState extends NoteState {}

class LoadingState extends NoteState {}

class LoadedState extends NoteState {
  LoadedState({required this.mData});

  List<NoteModel> mData;
}

class ErrorState extends NoteState {
  ErrorState({required this.errorMsg});

  String errorMsg;
}
