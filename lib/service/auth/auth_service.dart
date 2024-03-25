import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/user/user_datasource.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/secret.dart';

class AuthService {
  UserEntity? _user;

  static final AuthService instance = AuthService._internal();

  AuthService._internal();

  void _saveUser(UserEntity user) {
    _user = user;
  }

  UserEntity get user => _user ?? UserEntity.commom();

  Future<UserEntity?> getUser() async {
    if (_user != null) {
      return _user;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserEntity? userEntity = await _loadUserFirestore(user.email ?? '');
      if (userEntity != null) {
        _saveUser(userEntity);
        return userEntity;
      }
    }
    return null;
  }

  Future<void> _persist() async {
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
  }

  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signOut() async {
    if (kIsWeb) {
      await FirebaseAuth.instance.setPersistence(Persistence.NONE);
    }
    await FirebaseAuth.instance.signOut();
  }

  Future<User?> createAuthPassword(String emailAddress, String password) async {
    if (emailAddress.isEmpty || password.isEmpty) {
      return null;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Result<UserEntity, ErrorEntity>> signInPassword(
      String emailAddress, String password) async {
    if (emailAddress.isEmpty || password.isEmpty) {
      return Failure(ErrorEntity(code: EnumErrorCode.e06101, message: ''));
    }
    final UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    await _persist();
    if (credential.user == null) {
      return Failure(ErrorEntity(code: EnumErrorCode.e06101, message: ''));
    }
    UserEntity? user = await _loadUserFirestore(emailAddress);
    if (user != null) {
      _saveUser(user);
      return user.toSuccess();
    } else {
      return Failure(ErrorEntity(code: EnumErrorCode.e06101, message: ''));
    }
  }

  Future<UserEntity?> _loadUserFirestore(String email) async {
    try {
      return await UserDatasource().searchUserFromEmail(email).fold((success) {
        return success;
      }, (error) => null);
    } catch (e) {
      return null;
    }
  }

  Future<Result<UserEntity, ErrorEntity>> signInWithGoogle() async {
    User? user;

    GoogleSignInAccount? googleSignInAccount;

    if (kIsWeb) {
      try {
        googleSignInAccount = await GoogleSignIn().signIn();
      } catch (e) {
        print(e);
      }
      googleSignInAccount =
          await GoogleSignIn(clientId: GCP_WEB_SIGN_IN_ID).signInSilently();
    } else {
      googleSignInAccount = await GoogleSignIn().signIn();
    }

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        user = userCredential.user;
        if (user == null) {
          return Failure(ErrorEntity(code: EnumErrorCode.e06101, message: ''));
        }
        UserEntity? userEntity = await _loadUserFirestore(user.email ?? '');
        if (userEntity != null) {
          _saveUser(userEntity);
          return userEntity.toSuccess();
        } else {
          return Failure(ErrorEntity(code: EnumErrorCode.e06101, message: ''));
        }
      } catch (e) {
        return Failure(
            ErrorEntity(code: EnumErrorCode.unknown, message: e.toString()));
      }
    } else {
      return Failure(ErrorEntity(code: EnumErrorCode.e06101, message: ''));
    }
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
