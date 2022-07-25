// flow ///

// dialogState.getScreen();
// StateRenderer();


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer.dart';

class DialogLoadingStateImpl {
  Widget getScreen() {
    return StateRenderer(
      stateRendererType: StateRendererType.dialogLoadingState,
      retryActionButton: () {},
    );
  }
}

class DialogErrorStateImpl {
  final String error;

  DialogErrorStateImpl(this.error);

  Widget getScreen() {
    return StateRenderer(
      stateRendererType: StateRendererType.dialogErrorState,
      retryActionButton: () {},
      message: error,
    );
  }
}

class FullScreenErrorStateImpl {
  final Function retryActionFunction;
  final String error;

  FullScreenErrorStateImpl(this.retryActionFunction, this.error);

  Widget getScreen() {
    return StateRenderer(
      stateRendererType: StateRendererType.fullScreenErrorState,
      retryActionButton: retryActionFunction,
      message: error,
    );
  }
}

class FullScreenLoadingStateImpl {
  Widget getScreen() {
    return StateRenderer(
      stateRendererType: StateRendererType.fullScreenErrorState,
      retryActionButton: () {},
    );
  }
}

class FullScreenEmptyStateImpl {
  Widget getScreen() {
    return StateRenderer(
      stateRendererType: StateRendererType.fullScreenEmptyState,
      retryActionButton: () {},
    );
  }
}

////////////////////

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;

  LoadingState(this.stateRendererType);

  @override
  String getMessage() {
    return '';
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

class ErrorState extends FlowState {
  final String message;
  final StateRendererType stateRendererType;

  ErrorState(this.message, this.stateRendererType);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

class EmptyState extends FlowState {
  @override
  String getMessage() {
    return '';
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.fullScreenEmptyState;
  }
}

class ContentState extends FlowState {
  @override
  String getMessage() {
    return '';
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.contentState;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreen({
    required BuildContext context,
    required Widget contentView,
    required Function retryActionButton,
  }) {
    switch (runtimeType) {
      case LoadingState:
        log('Loading State ');
        if (getStateRendererType() == StateRendererType.dialogLoadingState) {
          showPopupDialog(
            context: context,
            stateRendererType: getStateRendererType(),
            message: '',
          );
          return contentView;
        }
        else {
          return StateRenderer(
            stateRendererType: StateRendererType.fullScreenLoadingState,
            retryActionButton: () {},

          );
        }
      case ErrorState:
        log('Error State ');
        log('Message ${getMessage()}');
        log('StateRenderer ${getStateRendererType()}');
        if (getStateRendererType() == StateRendererType.dialogErrorState) {
          dismissDialog(context);
          log('Executed');
          showPopupDialog(
            context: context,
            stateRendererType: getStateRendererType(),
              message: getMessage(),
          );
          return contentView;
        }
        else {
          return StateRenderer(
            stateRendererType: StateRendererType.fullScreenErrorState,
            retryActionButton: retryActionButton,
          );
        }

      case EmptyState:
        return StateRenderer(stateRendererType: getStateRendererType(), retryActionButton: (){});

      case ContentState:
        dismissDialog(context);
        return contentView;

      default:
        return contentView;
    }
  }

  void showPopupDialog({
    required BuildContext context,
    required StateRendererType stateRendererType,
    required String message,
  }) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) {
          return StateRenderer(
            stateRendererType: stateRendererType,
            retryActionButton: () {},
            message: message,
          );
        },
      );
    });

  }


  bool _isCurrentDialogShowing(BuildContext context){
    return ModalRoute.of(context)?.isCurrent != true;
  }

  void dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
