import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    // name: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    role: '',
    address: '',
    token: '',
    number: '',
    // cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
