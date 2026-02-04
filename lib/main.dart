import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/home_screen.dart';
import 'viewmodels/task_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_) => TaskViewModel(),
        child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
