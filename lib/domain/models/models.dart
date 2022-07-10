// onBoarding

class SliderObject {
  final String title, supTitle, imagePath;

  SliderObject(
    this.title,
    this.supTitle,
    this.imagePath,
  );
}

class SliderViewObject{

  final SliderObject sliderObject;
  final int currentIndex;
  final int numOfSliders;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSliders);
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