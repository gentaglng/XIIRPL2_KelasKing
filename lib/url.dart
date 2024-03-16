import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  String _url = 'http://192.168.230.251:8000/';

  String get url => _url;

  void updateUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }
}
