import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/res.dart';
import 'package:flutter_architecture/presentation/res/strings_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmpty,
  popupLoadingState,
  popupErrorState,
  contentState,
}

class StateRendererWidget extends StatelessWidget {

  final StateRendererType stateRendererType;
  final String title;
  final String message;
  final Function retryActionFunction;

  const StateRendererWidget({
    Key? key,
    required this.stateRendererType,
    required this.retryActionFunction,
    this.title = AppStrings.loading,
    this.message = AppStrings.loading,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
          children: [
            _getAnimatedImage(JsonManager.loadingAnimation),
            _getMessage(message),
          ],
        );
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn(
          children: [
            _getAnimatedImage(JsonManager.errorAnimation),
            _getMessage(message),
            _getRetryButton(
              buttonTitle: AppStrings.retryAgain,
              context: context,
            ),
          ],
        );
      case StateRendererType.fullScreenEmpty:
        return _getItemsColumn(children: []);
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(
          context: context,
          children: [
            _getAnimatedImage(JsonManager.emptyAnimation),
          ],
        );
      case StateRendererType.popupErrorState:
        return _getPopupDialog(
          context: context,
          children: [
            _getAnimatedImage(JsonManager.errorAnimation),
            _getMessage(message),
            _getRetryButton(buttonTitle: AppStrings.ok, context: context),
          ],
        );
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }

  }

  Widget _getItemsColumn({required List<Widget> children}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Text(
      message,
      style: getRegularStyle(
        color: ColorsManager.black,
        fontSize: FontSizes.s16,
      ),
    );
  }

  Widget _getRetryButton({
  required String buttonTitle,
    required BuildContext context,
}){
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if(stateRendererType == StateRendererType.fullScreenErrorState){
            retryActionFunction.call();
          }
          else{
            Navigator.pop(context);
          }
        },
        child: Text(buttonTitle),
      ),
    );
  }

  Widget _getPopupDialog({required BuildContext context, required List<Widget> children}){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorsManager.white,
        ),
        child: _getContentDialog(context: context, children: children),
      ),

    );
  }

  Widget _getContentDialog(
      {required BuildContext context, required List<Widget> children}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
