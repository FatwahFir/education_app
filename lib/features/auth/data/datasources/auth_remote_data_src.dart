import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:job_landing_course/core/enums/user_action_enum.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/core/utils/constants.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UserActionEnum action,
    required dynamic userData,
  });
}

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  AuthRemoteDataSrcImpl(
      {required FirebaseAuth authClient,
      required FirebaseFirestore cloudStoreClient,
      required FirebaseStorage dbClient})
      : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error occured',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<LocalUserModel> signIn(
      {required String email, required String password}) async {
    try {
      final res = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = res.user;

      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'unknown error',
        );
      }

      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      await _setUser(user, email);

      userData = await _getUserData(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      final userCreds = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCreds.user?.updateDisplayName(fullName);
      await userCreds.user?.updatePhotoURL(kDefaultAvatar);
      await _setUser(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error occured',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateUser(
      {required UserActionEnum action, required userData}) async {
    try {
      switch (action) {
        case UserActionEnum.fullName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData as String});
        case UserActionEnum.email:
          await _authClient.currentUser
              ?.verifyBeforeUpdateEmail(userData as String);
          await _updateUserData({'email': userData as String});
        case UserActionEnum.profilePic:
          final ref = _dbClient
              .ref()
              .child('profile.pics/${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
        case UserActionEnum.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: "User doesn't exists",
              statusCode: 'insufficient permission',
            );
          }

          final newData = jsonDecode(userData as String) as DataMap;

          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'],
            ),
          );

          await _authClient.currentUser?.updatePassword(
            newData['newPassword'],
          );
        case UserActionEnum.bio:
          await _updateUserData({'bio': userData as String});
        case UserActionEnum.points:
          await _updateUserData({'bio': userData as int});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error occured',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return await _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUser(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
            points: 0,
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}
