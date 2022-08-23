import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String get getMessage;
}

class LoadingState extends FlowState {
  final StateRendererType _stateRendererType;
  final String _message;

  LoadingState(this._stateRendererType, this._message);

  @override
  String get getMessage => _message;

  @override
  StateRendererType getStateRendererType() => _stateRendererType;
}

class ErrorState extends FlowState {
  final StateRendererType _stateRendererType;
  final String _message;
  final Function _retryActionButton;

  ErrorState(this._stateRendererType, this._message, this._retryActionButton);

  @override
  String get getMessage => _message;

  @override
  StateRendererType getStateRendererType() => _stateRendererType;

  Function getRetryActionButton() => _retryActionButton;
}

class EmptyState extends FlowState {
  final String _message;

  EmptyState(this._message);

  @override
  String get getMessage => _message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

class ContentState extends FlowState {
  @override
  String get getMessage => '';

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

extension FlowStateExtension on FlowState {
  Widget getScreen({
    required Widget contentScreen,
    required BuildContext context,
  }) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.dialogLoadingState) {
          showCustomDialog(context, getStateRendererType(), (){}, 'Loading dialog ', getMessage);
          return contentScreen;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionButton: () {},
            title: 'loading',
            message: getMessage,
          );
        }

      case ErrorState:
        if (getStateRendererType() == StateRendererType.dialogErrorState) {


          dismissDialog(context);
          showCustomDialog(context, getStateRendererType(), (){}, 'Error dialog ', getMessage);
          return contentScreen;
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionButton: () {},
            title: 'Error',
            message: getMessage,
          );
        }

      case EmptyState:
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          retryActionButton: () {},
          title: 'Error',
          message: getMessage,
        );
      default:
        return contentScreen;
    }
  }

  void showCustomDialog(
    BuildContext context,
    StateRendererType stateRendererType,
    Function retryActionButton,
    String title,
    String message,
  ) {

    WidgetsBinding.instance.addPostFrameCallback((_){
      showDialog(
        context: context,
        builder: (context) {
          return StateRenderer(
            stateRendererType: stateRendererType,
            retryActionButton: retryActionButton,
            title: title,
            message: message,
          );
        },
      );
    });

  }


  bool isCurrentDialogShowing(BuildContext context){
    return ModalRoute.of(context)?.isCurrent == false;
  }


  void dismissDialog(BuildContext context){
    if(isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
}
