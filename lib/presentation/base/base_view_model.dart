// Dart imports:


import 'dart:async';

import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends InputBaseViewModel
    with OutputBaseViewModel {

  final StreamController<FlowState> flowStateController = StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    flowStateController.close();
  }

  @override

  Sink get inputFlowStateSink => flowStateController.sink;

  @override
  Stream<FlowState> get outputFlowStateStream => flowStateController.stream;
}

abstract class InputBaseViewModel {

  void start();

  void dispose();

  Sink get inputFlowStateSink;
}

abstract class OutputBaseViewModel {

  Stream<FlowState> get outputFlowStateStream;
}
