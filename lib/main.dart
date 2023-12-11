import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_note_abrar/Cubit/note_cubit.dart';

import 'AppDataBase/app_db.dart';
import 'Screens/splash_screen.dart';

void main() {
  runApp(
    BlocProvider<NoteCubit>(
      create: (context) => NoteCubit(appDB: AppDataBase.instance),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
