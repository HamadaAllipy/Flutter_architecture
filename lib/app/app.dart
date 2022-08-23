import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/route_manager.dart';
import 'package:flutter_architecture/presentation/res/themes_manager.dart';

class MyApp extends StatefulWidget {

  const MyApp._();

  factory MyApp()=> _instance;

  static const _instance = MyApp._();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      theme: getLightTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
