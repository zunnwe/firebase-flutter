import 'dart:collection';

import 'package:comics_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserDataNotifier with ChangeNotifier {
  List<UserData> _dataList = [];
  UserData _currentpdf;

  UnmodifiableListView<UserData> get dataList => UnmodifiableListView(_dataList);

  UserData get currentPdf => _currentpdf;

  set userDataList(List<UserData> pdfList) {
    _dataList = pdfList;
    notifyListeners();
  }

  set currentPdf(UserData data) {
    _currentpdf = data;
    notifyListeners();
  }

  addPdf(UserData data) {
    _dataList.insert(0, data);
    notifyListeners();
  }

  deletePdf(UserData data) {
    _dataList.removeWhere((_pdf) => _pdf.id == data.id);
    notifyListeners();
  }
}
