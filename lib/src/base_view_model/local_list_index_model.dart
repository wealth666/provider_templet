import 'package:flutter/cupertino.dart';

abstract class LocalListIndexViewModel<T> with ChangeNotifier {
  List<T> getList();

  int _index = 0;

  int get index => _index;

  set index(int index) {
    if (_index != index) {
      _index = index;
      notifyListeners();
    }
  }

  T? getActive() => getList().length > index ? getList()[index] : null;
}
