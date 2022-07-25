import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/res.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // Dialog

  dialogLoadingState,
  dialogErrorState,

  // FullScreen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // content screen
  contentState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final Function retryActionButton;

  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    required this.retryActionButton,
    this.message = AppStrings.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getStateWidget(context);
  }

  Widget getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.dialogLoadingState:
        return _getDialog(
          [
            _getAnimatedImage(JsonManager.loadingAnimation),
          ],
        );
      case StateRendererType.dialogErrorState:
        return _getDialog(
          [
            _getAnimatedImage(JsonManager.errorAnimation),
            _getMessageText(message),
            const SizedBox(height: AppSize.s25),
            _getButton(context, AppStrings.ok),
            const SizedBox(height: AppSize.s25),
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonManager.loadingAnimation),
            _getMessageText(AppStrings.loading),
          ],
        );
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonManager.errorAnimation),
            _getMessageText(message),
            _getButton(context, AppStrings.retryAgain),
          ],
        );
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonManager.emptyAnimation),
            _getMessageText(AppStrings.noData),
          ],
        );
      case StateRendererType.contentState:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return Lottie.asset(animationName);
  }

  Widget _getMessageText(String text) {
    return Text(text);
  }

  Widget _getButton(BuildContext context, String titleButton) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.fullScreenErrorState) {
              retryActionButton.call();
            } else if (stateRendererType == StateRendererType.dialogErrorState) {
              Navigator.pop(context);
            }
          },
          child: Text(titleButton),
        ),
      ),
    );
  }

  Widget _getDialog(List<Widget> children) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: _getDialogContent(children),
      ),
    );
  }

  Widget _getDialogContent(List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
