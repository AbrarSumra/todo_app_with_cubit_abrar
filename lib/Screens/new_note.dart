import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_abrar/Cubit/note_cubit.dart';

import '../Model/note_model.dart';

class NewNoteScreen extends StatelessWidget {
  NewNoteScreen({
    super.key,
    this.isUpdate = false,
    this.userId = 0,
    this.noteIndex = 0,
    this.noteTitle = "",
    this.noteDesc = "",
  });

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final bool isUpdate;
  final int noteIndex;
  final int userId;
  final String noteTitle;
  final String noteDesc;

  @override
  Widget build(BuildContext context) {
    titleController.text = noteTitle;
    descController.text = noteDesc;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            isUpdate ? "Update Note" : "New Note",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 500,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  isUpdate ? "Update Note" : "New Note",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    label: const Text("Title"),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    label: const Text("Description"),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty &&
                            descController.text.isNotEmpty) {
                          if (isUpdate) {
                            /// Update Note
                            /*context.read<NoteProvider>().updateNote(NoteModel(
                                  user_id: userId,
                                  note_Id: noteIndex,
                                  note_Title: titleController.text.toString(),
                                  note_Desc: descController.text.toString(),
                                ));*/
                          } else {
                            /// Add Note
                            context.read<NoteCubit>().addNote(NoteModel(
                                  user_id: 0,
                                  note_Id: 0,
                                  note_Title: titleController.text.toString(),
                                  note_Desc: descController.text.toString(),
                                ));
                          }
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isUpdate ? "Update" : "Add",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
