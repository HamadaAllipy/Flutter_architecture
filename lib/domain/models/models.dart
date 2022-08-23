class SliderObject {
  final String title;
  final String supTitle;
  final String image;

  SliderObject(this.title, this.supTitle, this.image);
}

class CustomerModel {
  final String id;
  final String name;
  final int numOfNotification;

  CustomerModel({
    required this.id,
    required this.name,
    required this.numOfNotification,
  });
}

class ContactModel {
  final String phone;
  final String email;
  final String link;

  ContactModel({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class AuthenticationModel {
  CustomerModel? customerModel;
  ContactModel? contactModel;

  AuthenticationModel({
    required this.customerModel,
    required this.contactModel,
});
}