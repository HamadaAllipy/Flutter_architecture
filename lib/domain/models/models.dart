class SliderObject {
  final String title;
  final String supTitle;
  final String image;

  SliderObject(this.title, this.supTitle, this.image);
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int numOfSlider;
  final int currentIndex;

  SliderViewObject({
    required this.sliderObject,
    required this.currentIndex,
    required this.numOfSlider,
  });
}

class CustomerModel {
  String id;
  String name;
  int numOfNotification;

  CustomerModel(this.id, this.name, this.numOfNotification);
}

class ContactModel {
  String phone;
  String email;
  String link;

  ContactModel(this.phone, this.email, this.link);
}

class AuthenticationModel {
  CustomerModel? customerModel;
  ContactModel? contactModel;

  AuthenticationModel(this.customerModel, this.contactModel);
}
