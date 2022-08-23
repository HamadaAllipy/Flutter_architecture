
import 'dart:async';

import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {

  final StreamController<FlowState> _flowStreamController = StreamController<FlowState>.broadcast();

  @override
  Sink<FlowState> get inputFlowState => _flowStreamController.sink;

  @override
  Stream<FlowState> get outputFlowState => _flowStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _flowStreamController.close();
  }
}

abstract class BaseViewModelInput {
  void start();

  void dispose();

  Sink<FlowState> get inputFlowState;

}

abstract class BaseViewModelOutput {

  Stream<FlowState> get outputFlowState;

}
