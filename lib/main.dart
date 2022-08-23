import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/app.dart';
import 'package:flutter_architecture/app/di.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  runApp(MyApp());
}

