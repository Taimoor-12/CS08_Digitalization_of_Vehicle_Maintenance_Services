import 'package:flutter/material.dart';

class SwapCartButtonProvider extends ChangeNotifier {
  bool _cartButton = false;
  // bool _addedButton = false;
  // // final userProvider = Provider.of<UserProvider>(context, listen: false);
  // // int cartLength = userProvider.user.cart.length;
  // List<bool> _isSelected = [];

  bool get cartButton => _cartButton;
  // bool get addedButton => _addedButton;
  // List<bool> get isSelected => _isSelected;

  void setCartButton(bool set) {
    _cartButton = set;
    notifyListeners();
  }

  // void setCartList(bool set) {
  //   _isSelected.add(set);
  //   notifyListeners();
  // }
  //
  // void swapCartList(List<bool> list) {
  //   _isSelected = list;
  //   notifyListeners();
  // }
  //
  // void toggleCartButton() {
  //   _cartButton = !_cartButton;
  //   _addedButton = !_addedButton;
  //   notifyListeners();
  // }
  //
  // void setAddedButton(bool set) {
  //   _addedButton = set;
  //   notifyListeners();
  // }
}
