import 'package:flutter_architecture/app/constants.dart';
import 'package:flutter_architecture/app/constants.dart';
import 'package:flutter_architecture/app/extensions.dart';
import 'package:flutter_architecture/data/response/responses.dart';
import 'package:flutter_architecture/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotification.orZero() ?? Constants.zero);
  }
}

extension ContactResponseMapper on ContactResponse? {
  ContactModel toDomain() {
    return ContactModel(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  AuthenticationModel toDomain() {
    return AuthenticationModel(
        this?.customerResponse.toDomain(), this?.contactResponse.toDomain());
  }
}
