import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  String _url = 'http://10.212.75.206:8000/';

  String get url => _url;

  void updateUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }
}
