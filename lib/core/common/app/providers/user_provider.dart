import 'package:flutter/foundation.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? user) {
    if (user != _user) _user = user;
  }

  set user(LocalUserModel? user) {
    if (user != _user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
