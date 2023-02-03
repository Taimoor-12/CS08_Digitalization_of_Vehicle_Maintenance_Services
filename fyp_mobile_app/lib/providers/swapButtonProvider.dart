import 'package:flutter/material.dart';

class SwapButtonProvider extends ChangeNotifier {
  bool _eField = true;
  bool _swapButton = true;

  bool get eField => _eField;
  bool get swapButton => _swapButton;

  void seteField(bool set) {
    _eField = set;
    notifyListeners();
  }

  void setSwapButton(bool set) {
    _swapButton = set;
    notifyListeners();
  }
}
