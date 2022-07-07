import 'dart:developer';


abstract class BaseViewModel extends InputBaseViewModel
    with OutputBaseViewModel {}

abstract class InputBaseViewModel {

  void start();

  void dispose();
}

abstract class OutputBaseViewModel {}
