import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';

class VehicleDatasource {
  FirebaseFirestore firestore = getIt<FirebaseFirestore>();

  Future<List<Vehicle>> getVehiclesUser(String idUser) async {
    List<Vehicle> vehicles = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('vehicles')
          .where('user_id', isEqualTo: idUser)
          .get();
      for (var element in querySnapshot.docs) {
        Vehicle vehicle = Vehicle.fromMap(element.data());
        vehicle.id = element.id;
        vehicles.add(vehicle);
      }
      return vehicles;
    } catch (e) {
      print(e);
      return vehicles;
    }
  }

  Future<Result<Vehicle, ErrorEntity>> create(Vehicle vehicle) async {
    if (vehicle.userId.isEmpty) {
      return Failure(ErrorEntity.empty());
    }
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore.collection('vehicles').add(vehicle.toMap());
      vehicle.id = documentReference.id;
      return vehicle.toSuccess();
    } catch (e) {
      return Failure(ErrorEntity.empty());
    }
  }

  Future<Result<Vehicle, ErrorEntity>> update(Vehicle vehicle) async {
    if (vehicle.id == null) {
      return Failure(ErrorEntity.empty());
    }
    if (vehicle.id!.isEmpty) {
      return Failure(ErrorEntity.empty());
    }
    try {
      await firestore
          .collection('vehicles')
          .doc(vehicle.id)
          .update(vehicle.toMap());
      return vehicle.toSuccess();
    } catch (e) {
      return Failure(ErrorEntity.empty());
    }
  }

  Future<void> delete(String vehicleId) async {
    try {
      await firestore.collection('vehicles').doc(vehicleId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<Vehicle?> load(String vehicleId) async {
    try {
      if (vehicleId.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> doc =
            await firestore.collection('vehicles').doc(vehicleId).get();
        if (doc.data() != null) {
          return Vehicle.fromMap(doc.data()!);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
