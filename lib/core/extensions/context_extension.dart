import 'package:flutter/material.dart';
import 'package:job_landing_course/core/common/app/providers/user_provider.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';
import 'package:provider/provider.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  UserProvider get userProvider => read<UserProvider>();
  LocalUserModel? get currentUse => userProvider.user;
}
