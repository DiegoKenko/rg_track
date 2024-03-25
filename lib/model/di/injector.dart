// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:rg_track/service/notification/firebase_messaging_service.dart';
import 'package:rg_track/service/notification/local_notification_service.dart';
import 'package:rg_track/ui/auth/controller/auth_controller.dart';
import 'package:rg_track/ui/users/parent/cubit/users_parent_cubit.dart';

final GetIt getIt = GetIt.instance;
const String BOX_ACCOUNT = 'account_section';
const String KEY_ACCOUNT_LOGGED = 'logged_account';
const String BOX_CUSTOMER = 'customer_section';
const String KEY_CUSTOMER_SELECTED = 'selected_customer';

void injectionSetup() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());
  getIt.registerSingleton<AuthController>(AuthController());
  getIt.registerLazySingleton<UserParentCubit>(() => UserParentCubit());
  getIt.registerLazySingleton<FirebaseMessaging>(
      () => FirebaseMessaging.instance);
  getIt.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());
  getIt.registerLazySingleton<FirebaseMessagingService>(() =>
      FirebaseMessagingService(getIt<LocalNotificationService>())
        ..initialize());
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
}
