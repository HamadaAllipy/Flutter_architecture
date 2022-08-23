import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/constants_manager.dart';
import 'package:flutter_architecture/presentation/res/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  late Timer _timer;

  @override
  void initState() {
    startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startDelay(){
    _timer = Timer(const Duration(seconds: ConstantsManager.splashTimer), _next);
  }

  void _next(){
    Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      appBar: AppBar(
        backgroundColor: ColorsManager.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: ColorsManager.primary
        ),
      ),
      body: Center(
        child: Image.asset(ImagesManager.splashLogo),
      ),
    );
  }
}
