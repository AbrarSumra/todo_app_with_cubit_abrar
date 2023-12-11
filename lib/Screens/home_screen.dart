import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Cubit/note_cubit.dart';
import '../Cubit/note_state.dart';
import 'login_screen.dart';
import 'new_note.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// For get All Note without using InitState and Without Stateful Class that's why GET ALL NOTE here...
    context.read<NoteCubit>().getAllNotes();

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setBool(LoginScreen.LOGIN_PREFS_KEY, false);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => LoginScreen()));
                },
                icon: const Icon(Icons.login_outlined),
                label: const Text("Log out"),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Todo App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorState) {
          return Center(
            child: Text(
              state.errorMsg,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        }

        if (state is LoadedState) {
          return state.mData.isNotEmpty
              ? ListView.builder(
                  itemCount: state.mData.length,
                  itemBuilder: (ctx, index) {
                    var currData = state.mData[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(currData.note_Title),
                      subtitle: Text(currData.note_Desc),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => NewNoteScreen(
                                              isUpdate: true,
                                              userId: currData.user_id,
                                              noteIndex: currData.note_Id,
                                              noteTitle: currData.note_Title,
                                              noteDesc: currData.note_Desc,
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Delete?"),
                                      content: const Text(
                                          "Are you sure want to delete?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            /// delete operations
                                            /*context
                                                .read<NoteProvider>()
                                                .deleteNote(currData.note_Id);*/
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text("No any notes added"),
                );
        }

        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// For Next Page to Get Data
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => NewNoteScreen()));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
