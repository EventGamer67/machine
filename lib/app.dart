import 'package:flutter/material.dart';
import 'package:machine/presentation/admin_screen.dart';
import 'package:machine/presentation/home_screen.dart';
import 'package:machine/presentation/shared/tools.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'В ДЕТАЛЯХ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
