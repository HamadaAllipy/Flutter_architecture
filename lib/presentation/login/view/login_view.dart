import 'package:flutter/material.dart';
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
  final LoginViewModel _viewModel = LoginViewModel();


  @override
  void initState() {
    bind();
    super.initState();
  }

  void bind(){
    _passwordController.addListener(() {
      _viewModel.setPassword = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getContentWidget());
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
                stream: _viewModel.outputIsEmailValid,
                builder: (context, snapshot) {
                  bool isValid = snapshot.data??true;
                  return TextFormField(
                    onChanged: (value){
                      _viewModel.inputEmail.add(value);
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: StringsManager.email,
                      labelText: StringsManager.email,
                      errorText: isValid? null : StringsManager.emailError,
                    ),
                  );
                }
              ),
              const SizedBox(
                height: AppSizes.s45,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) {
                  bool isValid = snapshot.data??true;
                  return TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: StringsManager.password,
                      labelText: StringsManager.password,
                      errorText: isValid? null : StringsManager.emailError,
                    ),
                  );
                }
              ),
              const SizedBox(
                height: AppSizes.s45,
              ),
              const SizedBox(
                width: double.infinity,
                height: AppSizes.s45,
                child: ElevatedButton(
                  onPressed: null,
                  child: Text(
                    StringsManager.login,
                  ),
                ),
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
                          fontSize: FontSizes.s12, color: ColorsManager.error),
                    ),
                    onPressed: () {},
                    child: const Text(StringsManager.forgetPassword),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: getRegular(
                          fontSize: FontSizes.s12, color: ColorsManager.error),
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
}
