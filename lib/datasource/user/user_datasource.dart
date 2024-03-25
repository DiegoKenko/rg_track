import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';

class UserDatasource {
  FirebaseFirestore firestore = getIt<FirebaseFirestore>();

  Future<List<UserEntity>> getUsers(String parentId) async {
    if (parentId.isEmpty) {
      return [];
    }
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('users')
          .where('parent_id', isEqualTo: parentId)
          .get();
      var docs = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
        var data = e.data();
        data['id'] = e.id;
        return data;
      }).toList();
      return docs
          .map((Map<String, dynamic> e) => UserEntity.fromMap(e))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Result<UserEntity, ErrorEntity>> getUser(String id) async {
    if (id.isNotEmpty) {
      try {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await firestore.collection('users').doc(id).get();
        if (documentSnapshot.data() != null) {
          return UserEntity.fromMap(documentSnapshot.data()!).toSuccess();
        } else {
          return Failure(ErrorEntity.empty());
        }
      } catch (e) {
        return Failure(ErrorEntity.empty());
      }
    }
    return Failure(ErrorEntity.empty());
  }

  Future<Result<UserEntity, ErrorEntity>> searchUserFromEmail(
      String email) async {
    if (email.isNotEmpty) {
      try {
        final QuerySnapshot<Map<String, dynamic>> snap = await firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();
        if (snap.docs.isNotEmpty) {
          UserEntity user = UserEntity.fromMap(snap.docs.first.data());
          user = user.copyWith(id: snap.docs.first.id);
          return user.toSuccess();
        } else {
          return Failure(ErrorEntity.empty());
        }
      } catch (e) {
        return Failure(ErrorEntity.empty());
      }
    }
    return Failure(ErrorEntity.empty());
  }

  Future<Result<UserEntity, ErrorEntity>> createUser(UserEntity user) async {
    try {
      String id = user.id ?? '';
      await getUser(user.id ?? '').fold((success) => user = success, (error) {
        id = '';
      });
      if (id.isEmpty) {
        DocumentReference doc =
            await firestore.collection('users').add(user.toMap());
        user = user.copyWith(id: doc.id);
        await getUser(user.id ?? '').onSuccess((doc) => user = doc);
      }
      return user.toSuccess();
    } catch (e) {
      return Failure(ErrorEntity.empty());
    }
  }

  Future<Result<UserEntity, ErrorEntity>> updateUser(UserEntity user) async {
    if (user.id == null) {
      return Failure(ErrorEntity.empty());
    }
    try {
      await firestore.collection('users').doc(user.id).update(user.toMap());
      return user.toSuccess();
    } catch (e) {
      return Failure(ErrorEntity.empty());
    }
  }

  Future<void> deleteUser(String id) async {
    await firestore.collection('users').doc(id).delete();
  }

  Future<List<Map<String, dynamic>>> searchUsers(String keyword) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: keyword)
        .where('name', isLessThanOrEqualTo: '$keyword\uf8ff')
        .get();
    return querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => e.data())
        .toList();
  }
}
