import 'package:flutter/material.dart';

class ButtonActive with ChangeNotifier {
  bool _activeButtonEmailOrPhone = false;
  bool _activeButtonPassword = false;

  bool _nameActive = false;
  bool _vehicleActive = false;
  bool _makeActive = false;
  bool _modelActive = false;
  bool _homeaddressActive = false;

  bool get activeButtonEmailOrPhone => _activeButtonEmailOrPhone;
  bool get activeButtonPassword => _activeButtonPassword;

  bool get nameActive => _nameActive;
  bool get vehicleActive => _vehicleActive;
  bool get makeActive => _makeActive;
  bool get modelActive => _modelActive;
  bool get homeaddressActive => _homeaddressActive;

  void setActiveButton(bool set) {
    _activeButtonEmailOrPhone = set;
    notifyListeners();
  }

  void setActiveButtonPassword(bool set) {
    _activeButtonPassword = set;
    notifyListeners();
  }

  bool activeBoth(bool active1, bool active2) {
    if (active1 == true && active2 == true) {
      return true;
    } else {
      return false;
    }
  }

  bool activeOne(bool active) {
    if (active == true) {
      return true;
    } else {
      return false;
    }
  }

  void setActiveName(bool set) {
    _nameActive = set;
    notifyListeners();
  }

  void setActiveVehicleName(bool set) {
    _vehicleActive = set;
    notifyListeners();
  }

  void setActiveMakeName(bool set) {
    _makeActive = set;
    notifyListeners();
  }

  void setActiveModelName(bool set) {
    _modelActive = set;
    notifyListeners();
  }

  void setActiveAddressName(bool set) {
    _homeaddressActive = set;
    notifyListeners();
  }

  bool activeAll(bool active1, bool active2, bool active3, bool active4,
      bool active5, bool active6) {
    if (active1 == true &&
        active2 == true &&
        active3 == true &&
        active4 == true &&
        active5 == true &&
        active6 == true) {
      return true;
    } else {
      return false;
    }
  }
}
