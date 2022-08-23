import 'package:flutter_architecture/app/app_constants.dart';
import 'package:flutter_architecture/app/extensions.dart';
import 'package:flutter_architecture/data/response/response.dart';
import 'package:flutter_architecture/domain/models/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      id: this?.id.orEmpty() ?? AppConstant.empty,
      name: this?.name.orEmpty() ?? AppConstant.empty,
      numOfNotification: this?.numOfNotification.orZero() ?? AppConstant.zero,
    );
  }
}

extension ContactResponseMapper on ContactResponse? {
  ContactModel toDomain() {
    return ContactModel(
      phone: this?.phone.orEmpty() ?? AppConstant.empty,
      email: this?.email.orEmpty() ?? AppConstant.empty,
      link: this?.link.orEmpty() ?? AppConstant.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  AuthenticationModel toDomain() {
    return AuthenticationModel(
      customerModel: this?.customer.toDomain(),
      contactModel: this?.contact.toDomain(),
    );
  }
}
