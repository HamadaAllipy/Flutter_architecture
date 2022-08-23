import 'package:flutter_architecture/app/app_constants.dart';

extension NunNullString on String? {

  String orEmpty(){
    if(this == null){
      return AppConstant.empty;
    }
    else{
      return this!;
    }
  }
}extension NunNullInteger on int? {

  int orZero(){
    if(this == null){
      return AppConstant.zero;
    }
    else{
      return this!;
    }
  }
}