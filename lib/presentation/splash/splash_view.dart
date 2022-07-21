// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/app_constants.dart';
import 'package:flutter_architecture/presentation/res/res.dart';

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
    // startDelay();
    super.initState();
  }

  void startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDaley), _goNext);
  }

  _goNext() {
    Navigator.pushNamed(context, Routes.onBoardingRoute);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
