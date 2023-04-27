import 'package:flutter/material.dart';
import 'package:kuraklik_riskim/views/home_view.dart';
import 'package:kuraklik_riskim/views/login_view.dart';
import 'package:kuraklik_riskim/views/register_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeView());
  }
}
