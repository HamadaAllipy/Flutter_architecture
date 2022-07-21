// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';

// Project imports:
import 'presentation/res/res.dart';

part 'app/app.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await  initAppModule();
  runApp(MyApp());

}
