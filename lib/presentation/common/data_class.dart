import 'package:freezed_annotation/freezed_annotation.dart';
part 'data_class.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject({
    required String email,
    required String password,
  }) = _LoginObject;
}
