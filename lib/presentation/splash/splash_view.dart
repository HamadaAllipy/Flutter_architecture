import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  late final Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      body: Center(
        child: Image.asset(ImagesManager.splashLogo),
      ),
    );
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  void _startDelay() {
    _timer =  Timer(const Duration(seconds: 2), _next);
  }

  void _next() {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }
}
