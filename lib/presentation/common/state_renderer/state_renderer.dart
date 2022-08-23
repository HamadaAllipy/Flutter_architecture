import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // full screen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // dialog
  dialogLoadingState,
  dialogErrorState,
  contentState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionButton;

  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    required this.retryActionButton,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getWidgetState(context);
  }

  Widget _getWidgetState(context) {
    switch (stateRendererType) {
      case StateRendererType.fullScreenLoadingState:
        return _getColumn([
          _getAnimatedImage(JsonManager.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getColumn([
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
          _getRetryButton(title, context),

        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getColumn([
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
        ]);
      case StateRendererType.dialogLoadingState:
        return _getDialog(
          [
            _getAnimatedImage(JsonManager.loading),
          ],
        );
      case StateRendererType.dialogErrorState:
        return _getDialog(
          [
            _getAnimatedImage(JsonManager.error),
            _getMessage(message),
            _getRetryButton(title, context),
          ],
        );
      case StateRendererType.contentState:
        return _getDialog(
          [
            _getAnimatedImage(JsonManager.error),
            _getMessage(message),
          ],
        );
    }
  }

  Widget _getColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return Lottie.asset(animationName);
  }

  Widget _getMessage(String message) {
    return Text(message);
  }

  Widget _getRetryButton(String titleButton, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if(stateRendererType == StateRendererType.dialogErrorState){
          Navigator.of(context).pop();
        }
        else{
          retryActionButton.call();
        }
      },
      child: Text(titleButton),
    );
  }


  Widget _getDialog(List<Widget> children){
    return Dialog(
      elevation: 1.5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsManager.white,
        ),
        child: _getContentDialog(children),
      ),
    );
  }

  Widget _getContentDialog(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }


}
