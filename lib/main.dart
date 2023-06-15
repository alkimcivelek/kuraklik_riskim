import 'package:flutter/material.dart';
import 'package:kuraklik_riskim/views/home_view.dart';
import 'package:kuraklik_riskim/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasToken = false;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    setState(() {
      hasToken = token != null && token.isNotEmpty;
    });

    if (hasToken) {
      navigateToHome();
    } else {
      navigateToLogin();
    }
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeView(),
    ));
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginView(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
