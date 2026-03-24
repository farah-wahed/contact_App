import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/Modules/Core/Constants/app_Assets.dart';

import '../Core/Constants/AppRoutesName.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutesName.homeRout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29384D),
      body: Align(
        alignment: Alignment.center,
        child: Image.asset(AppAssets.routeImage, height: 60),
      ),
    );
  }
}
