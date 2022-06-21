import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/routes_manager.dart';

class MyApp extends StatefulWidget {

  const MyApp._internal();

  static const _instance = MyApp._internal();
  factory MyApp(){
    return _instance;
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      onGenerateRoute: RoutesGenerator.getRoute,
    );
  }
}
