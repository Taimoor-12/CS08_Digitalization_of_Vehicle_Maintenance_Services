import 'package:flutter/material.dart';

class Email with ChangeNotifier {
  String _email = "";
  String _phone = "";
  String _password = "";
  bool _emailOr = true;
  String _confirmPassword = "";

  String _fullName = "";
  String _firstName = "";
  String _lastName = "";
  String _vehicleName = "";
  String _make = "";
  String _model = "";
  String _homeAddress = "";
  int _dollarMoney = 0;
  int _rupeeMoney = 0;

  String get email => _email;
  String get confirmPassword => _confirmPassword;
  String get phone => _phone;
  String get password => _password;
  bool get emailOr => _emailOr;
  int get dollarMoney => _dollarMoney;
  int get rupeeMoney => _rupeeMoney;

  String get fullName => _fullName;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get vehicleName => _vehicleName;
  String get make => _make;
  String get model => _model;
  String get homeAdress => _homeAddress;

  // Email(String email, String password) {
  //   _email = email;
  //   _password = password;
  // }

  void setEmail(String em) {
    _email = em;
    notifyListeners();
  }

  void setPhone(String ph) {
    _phone = ph;
    notifyListeners();
  }

  void setDollar(int dollar) {
    _dollarMoney = dollar;
    notifyListeners();
  }

  void setRupee(int rupee) {
    _rupeeMoney = rupee;
    notifyListeners();
  }

  void setFullName(String name) {
    _fullName = name;
    notifyListeners();
  }

  void setFirstName(String name) {
    _firstName = name;
    notifyListeners();
  }

  void setLastName(String name) {
    _lastName = name;
    notifyListeners();
  }

  void setVehicleName(String name) {
    _vehicleName = name;
    notifyListeners();
  }

  void setMake(String name) {
    _make = name;
    notifyListeners();
  }

  void setModel(String model) {
    _model = model;
    notifyListeners();
  }

  void setAddress(String address) {
    _homeAddress = address;
    notifyListeners();
  }

  void setPassword(String pass) {
    _password = pass;
    notifyListeners();
  }

  void setConfirmPassword(String pass) {
    _confirmPassword = pass;
    notifyListeners();
  }

  void setEmailOrPhoneStatus(bool set) {
    _emailOr = set;
    notifyListeners();
  }
}
