import 'package:flutter/material.dart';
import 'package:myapp/signup.dart';
import 'package:provider/provider.dart';
import 'profile/usermodel.dart';
import 'additem/item_model.dart';
import 'favourite/favourite_model.dart';
import 'dart:async';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userModel()),
        ChangeNotifierProvider(create: (context) => ItemModel()),
        ChangeNotifierProvider(create: (context) => FavoriteModel())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // 👈 Start from Splash
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Image.asset(
          'assets/tir.jpg',
          width: 180,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
