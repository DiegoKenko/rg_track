import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/error_entity.dart';

class CustomerDatasource {
  final FirebaseFirestore _firestore = getIt<FirebaseFirestore>();
  Future<Result<Customer, ErrorEntity>> getCustomer(String id) async {
    try {
      if (id.isEmpty) {
        return ErrorEntity(code: EnumErrorCode.e05104, message: '').toFailure();
      }
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('users').doc(id).get();
      if (doc.exists) {
        return Customer.fromMap(doc.data()!).toSuccess();
      }
      return ErrorEntity(
              code: EnumErrorCode.e05101, message: 'Usuário não encontrado')
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e05101, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<List<Customer>, ErrorEntity>> getCustomersUser(
      String userId) async {
    try {
      if (userId.isEmpty) {
        return <Customer>[].toSuccess();
      }
      QuerySnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('users')
          .where('parent_id', isEqualTo: userId)
          .get();
      if (doc.docs.isNotEmpty) {
        return doc.docs
            .map((e) {
              Customer customer = Customer.fromMap(e.data());
              customer = customer.copyWith(id: e.id);
              return customer;
            })
            .toList()
            .toSuccess();
      }
      return <Customer>[].toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<Customer, ErrorEntity>> create(Customer customer) async {
    try {
      await _firestore
          .collection('users')
          .doc(customer.id)
          .set(customer.toMap());
      return customer.toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<Customer, ErrorEntity>> update(Customer customer) async {
    try {
      await _firestore
          .collection('users')
          .doc(customer.id)
          .update(customer.toMap());
      return customer.toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<bool, ErrorEntity>> delete(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
      return true.toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }
}
