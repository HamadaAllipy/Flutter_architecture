import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/presentation/login/view/login_view.dart';
import 'package:flutter_architecture/presentation/on_boarding/view/on_boarding_view.dart';
import 'package:flutter_architecture/presentation/res/Strings_manager.dart';
import 'package:flutter_architecture/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
}

class RouteGenerator {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return _moveRoute(const SplashView());
      case Routes.onBoardingRoute:
        return _moveRoute(const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return _moveRoute(const LoginView());
      default:
        return _moveRoute(const NoRouteFound());
    }
  }

  static PageRoute _moveRoute(Widget widget) {
   return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          StringsManager.noRouteFound,
        ),
      ),
    );
  }
}
