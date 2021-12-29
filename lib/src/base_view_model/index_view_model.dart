abstract class IndexViewModel<R> {

  notifyListeners();

  List<R> get indexList;

  int _index = 0;

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  R? get active => indexList.isNotEmpty && index < indexList.length ? indexList[index] : null;
}
