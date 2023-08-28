import 'package:flutter/material.dart';
import 'package:healthyou_app/model/user/user_info_model.dart';
import 'package:healthyou_app/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserRepository? repository;
  UserInfoModel? get info => repository?.info;
  bool isReady = false;

  UserProvider({this.repository}) {
    initialized();
  }

  initialized() {
    repository ??= UserRepository();
    repository?.initialized().then((_) {
      isReady = true;
      notifyListeners();
    });
  }

  void updateInfo(Map<String, dynamic> data) {
    repository?.updateInfo(data);
    notifyListeners();
  }

  void clearInfo() {
    repository?.clearInfo();
    notifyListeners();
  }

  String checkUpdated() {
    return repository!.checkUpdated();
  }
}
