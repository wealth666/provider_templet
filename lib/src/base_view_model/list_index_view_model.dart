
import 'list_view_model.dart';

abstract class ListIndexViewModel<R> extends ListViewModel<R> {
  int _index = 0;

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  get active => index < list.length ? list[index] : null;
}
