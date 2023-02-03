import 'package:flutter/material.dart';

class TextController with ChangeNotifier {
  late TextEditingController _messageTextControllerName;
  TextEditingController _messageTextControllerVehicle = TextEditingController();
  TextEditingController _messageTextControllerMake = TextEditingController();
  TextEditingController _messageTextControllerModel = TextEditingController();
  TextEditingController _messageTextControllerAddress = TextEditingController();

  TextEditingController get getMessageTextControllerName =>
      _messageTextControllerName;
  TextEditingController get getMessageTextControllerVehicle =>
      _messageTextControllerVehicle;
  TextEditingController get getMessageTextControllerMake =>
      _messageTextControllerMake;
  TextEditingController get getMessageTextControllerModel =>
      _messageTextControllerModel;
  TextEditingController get getMessageTextControllerAddress =>
      _messageTextControllerAddress;

  void setMessageTextControllerName(
      TextEditingController messageTextController) {
    _messageTextControllerName = messageTextController;
    notifyListeners();
  }

  void setMessageTextControllerVehicle(
      TextEditingController messageTextController) {
    _messageTextControllerVehicle = messageTextController;
  }

  void setMessageTextControllerMake(
      TextEditingController messageTextController) {
    _messageTextControllerMake = messageTextController;
  }

  void setMessageTextControllerModel(
      TextEditingController messageTextController) {
    _messageTextControllerModel = messageTextController;
  }

  void setMessageTextControllerAddress(
      TextEditingController messageTextController) {
    _messageTextControllerAddress = messageTextController;
  }
}
