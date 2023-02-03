import 'package:flutter/material.dart';

import '../models/service_provider_model.dart';

class ServiceProviderProvider extends ChangeNotifier {
  List<ServiceProvider> _listPro = [];
  List<ServiceProvider> _listFeatured = [];
  List<ServiceProvider> _listSearch = [];

  List<ServiceProvider> get listPro => _listPro;
  List<ServiceProvider> get listFeatured => _listFeatured;
  List<ServiceProvider> get listSearch => _listSearch;

  void assignList(List<ServiceProvider> list) {
    _listPro = list;
    notifyListeners();
  }

  void assignFeatured(List<ServiceProvider> list) {
    _listFeatured = list;
    notifyListeners();
  }

  void assignSearch(List<ServiceProvider> list) {
    _listSearch = list;
    notifyListeners();
  }
}
