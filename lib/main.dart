import 'package:flutter/material.dart';

import 'Modules/Splash/SplashView.dart';
import 'Modules/core/Constants/AppRoutesName.dart';
import 'Modules/home/HomeView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: AppRoutesName.splashRoute,
      routes: {
        AppRoutesName.splashRoute: (context) => const SplashView(),
        AppRoutesName.homeRout: (context) => const HomeView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
