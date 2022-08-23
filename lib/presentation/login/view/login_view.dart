import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_architecture/presentation/login/viewModel/login_view_model.dart';
import 'package:flutter_architecture/presentation/res/Strings_manager.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/fonts_manager.dart';
import 'package:flutter_architecture/presentation/res/styles_manager.dart';
import 'package:flutter_architecture/presentation/res/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputFlowState,
      builder: (context, snapshot) {
        return Scaffold(
          body: snapshot.data?.getScreen(contentScreen: _getContentWidget(), context: context)??_getContentWidget(),
        );
      }
    );
  }

  Widget _getContentWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(ImagesManager.splashLogo),
              const SizedBox(
                height: AppSizes.s45,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outputEmail,
                  builder: (context, snapshot) {
                    bool isValid = snapshot.data ?? true;
                    return TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: StringsManager.email,
                        labelText: StringsManager.email,
                        errorText: isValid ? null : StringsManager.emailError,
                      ),
                    );
                  }),
              const SizedBox(
                height: AppSizes.s45,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outputPassword,
                  builder: (context, snapshot) {
                    bool isValid = snapshot.data ?? true;
                    return TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: StringsManager.password,
                        labelText: StringsManager.password,
                        errorText:
                        isValid ? null : StringsManager.passwordError,
                      ),
                    );
                  }),
              const SizedBox(
                height: AppSizes.s45,
              ),
              SizedBox(
                width: double.infinity,
                height: AppSizes.s45,
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputEnableLoginButton,
                    builder: (context, snapshot) {
                      bool isValid = snapshot.data ?? false;
                      return ElevatedButton(
                        onPressed: isValid ? _viewModel.login : null,
                        child: const Text(
                          StringsManager.login,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSizes.s45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: getRegular(
                          fontSize: FontSizes.s12,
                          color: ColorsManager.error),
                    ),
                    onPressed: () {},
                    child: const Text(StringsManager.forgetPassword),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: getRegular(
                          fontSize: FontSizes.s12,
                          color: ColorsManager.error),
                    ),
                    onPressed: () {},
                    child: const Text(StringsManager.registerText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  void _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
