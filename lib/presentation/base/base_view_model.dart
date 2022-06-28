abstract class BaseViewModel extends _BaseViewModelInput
    with _BaseViewModelOutput {}

abstract class _BaseViewModelInput {
  void start();

  void dispose();
}

abstract class _BaseViewModelOutput {}
