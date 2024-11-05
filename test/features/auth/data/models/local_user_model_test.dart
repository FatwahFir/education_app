import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocalUserModel = LocalUserModel.empty();

  test("Should be a subclass of [LocalUser]", () {
    expect(tLocalUserModel, isA<LocalUser>());
  });

  final tMap = jsonDecode(fixture('user.json')) as DataMap;

  group("fromMap", () {
    test("Shold return valid data of [LocalUserModel]", () {
      final res = LocalUserModel.fromMap(tMap);

      expect(res, isA<LocalUserModel>());
      expect(res, equals(tLocalUserModel));
    });
  });

  group("toMap", () {
    test("Should return a valid data [DataMap] from model", () {
      final res = tLocalUserModel.toMap();
      expect(res, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'Should return a valid data [LocalUserModel] with updated values',
      () {
        final res = tLocalUserModel.copyWith(uid: '2');
        expect(res.uid, equals('2'));
      },
    );
  });
}
