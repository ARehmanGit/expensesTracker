import 'package:expensetracker/expenseshome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Poppins').copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE2725B)),
          useMaterial3: true),
      home: const ExpensesHome(),
    );
  }
}
