import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';

class Device {
  EnumBrand? brand;
  EnumModel? model;
  String? serial;
  String? controlNumber;
  String? imei;
  String? password;
  String? firmwareVersion;
  String? mobileOperator;
  bool? busy;
  DateTime? habilitatedAt;
  String? simNumber;
  String? simPin;
  String? simPuk;
  String? simApn;
  String? simApnUser;
  String? simApnPassword;
  String? simIccid;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? id;
  String? cid;
  String? userId;
  String? vehicleId;
  String? channelId;
  int? installation;
  String? customerId;
  Customer? customer;

  String get userIdSimple => (userId ?? '').substring(0, 6);

  String get imeiFormatted {
    return this.imei?.replaceAllMapped(
            RegExp(r'^(\d{5})(\d{9})(\d)$'),
            (Match match) =>
                "${match.group(1)}-${match.group(2)}-${match.group(3)}") ??
        "-";
  }

  Device({
    this.brand,
    this.model,
    this.serial,
    this.controlNumber,
    this.imei,
    this.password,
    this.customerId,
    this.firmwareVersion,
    this.busy = false,
    this.mobileOperator,
    this.habilitatedAt,
    this.simNumber,
    this.simPin,
    this.simPuk,
    this.simApn,
    this.simApnUser,
    this.simApnPassword,
    this.simIccid,
    this.updatedAt,
    this.createdAt,
    this.userId,
    this.vehicleId,
    this.channelId,
    this.id,
    this.cid,
    this.installation,
    this.customer,
  });

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        brand: EnumBrand.values.firstWhereOrNull(
          (element) => element.description == json["brand"],
        ),
        model: EnumModel.values.firstWhereOrNull(
          (element) => element.description == json["model"],
        ),
        serial: json["serial"],
        controlNumber: json["control_number"],
        imei: json["imei"],
        password: json["password"],
        firmwareVersion: json["firmware_version"],
        busy: json["busy"] == true,
        mobileOperator: json["mobile_operator"],
        habilitatedAt: json["habilitated_at"] == null
            ? null
            : DateTime.tryParse(json["habilitated_at"] ?? ''),
        simNumber: json["sim_number"],
        simPin: json["sim_pin"],
        simPuk: json["sim_puk"],
        simApn: json["sim_apn"],
        simApnUser: json["sim_apn_user"],
        simApnPassword: json["sim_apn_password"],
        simIccid: json["sim_iccid"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"] ?? ''),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"] ?? ''),
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        channelId: json["channel_id"],
        id: json["id"],
        cid: json["cid"],
        installation: json['installation'],
        customerId: json['customer_id'],
      );

  Device copyWith({
    EnumBrand? brand,
    EnumModel? model,
    String? serial,
    String? controlNumber,
    String? imei,
    String? password,
    String? firmwareVersion,
    bool? busy,
    String? mobileOperator,
    DateTime? habilitatedAt,
    String? simNumber,
    String? simPin,
    String? simPuk,
    String? simApn,
    String? simApnUser,
    String? simApnPassword,
    String? simIccid,
    DateTime? updatedAt,
    DateTime? createdAt,
    Customer? customer,
    String? userId,
    String? customerId,
    String? vehicleId,
    int? channelId,
    String? id,
    String? cid,
    int? installation,
  }) =>
      Device(
        brand: brand ?? this.brand,
        model: model ?? this.model,
        serial: serial ?? this.serial,
        controlNumber: controlNumber ?? this.controlNumber,
        imei: imei ?? this.imei,
        password: password ?? this.password,
        firmwareVersion: firmwareVersion ?? this.firmwareVersion,
        busy: busy ?? this.busy,
        mobileOperator: mobileOperator ?? this.mobileOperator,
        habilitatedAt: habilitatedAt ?? this.habilitatedAt,
        simNumber: simNumber ?? this.simNumber,
        simPin: simPin ?? this.simPin,
        simPuk: simPuk ?? this.simPuk,
        simApn: simApn ?? this.simApn,
        simApnUser: simApnUser ?? this.simApnUser,
        simApnPassword: simApnPassword ?? this.simApnPassword,
        simIccid: simIccid ?? this.simIccid,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        userId: userId ?? this.userId,
        vehicleId: vehicleId ?? this.vehicleId,
        id: id ?? this.id,
        cid: cid ?? this.cid,
        installation: installation ?? this.installation,
        customerId: customerId ?? this.customerId,
        customer: customer ?? this.customer,
      );

  Device copyWithFlespi(FlespiDevice flespiDevice) {
    EnumModel? model = EnumModel.values.firstWhereOrNull(
      (element) => element.flespiId == flespiDevice.deviceTypeId,
    );

    return Device(
      brand: model?.brand ?? this.brand,
      model: model ?? this.model,
      serial: serial ?? this.serial,
      controlNumber: controlNumber ?? this.controlNumber,
      imei: flespiDevice.imei,
      password: password ?? this.password,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      busy: busy ?? this.busy,
      mobileOperator: mobileOperator ?? this.mobileOperator,
      habilitatedAt: habilitatedAt ?? this.habilitatedAt,
      simNumber: simNumber ?? this.simNumber,
      simPin: simPin ?? this.simPin,
      simPuk: simPuk ?? this.simPuk,
      simApn: simApn ?? this.simApn,
      simApnUser: simApnUser ?? this.simApnUser,
      simApnPassword: simApnPassword ?? this.simApnPassword,
      simIccid: simIccid ?? this.simIccid,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      vehicleId: vehicleId ?? this.vehicleId,
      channelId: flespiDevice.channelId ?? this.channelId,
      id: flespiDevice.id?.toString() ?? this.id,
      cid: flespiDevice.cid?.toString() ?? this.cid,
      installation: installation ?? this.installation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "brand": brand?.description,
      "model": model?.description,
      "serial": serial,
      "control_number": controlNumber,
      "imei": imei,
      "password": password,
      "firmware_version": firmwareVersion,
      "busy": busy,
      "mobile_operator": mobileOperator,
      "habilitated_at":
          "${habilitatedAt?.year.toString().padLeft(4, '0')}-${habilitatedAt?.month.toString().padLeft(2, '0')}-${habilitatedAt?.day.toString().padLeft(2, '0')}",
      "sim_number": simNumber,
      "sim_pin": simPin,
      "sim_puk": simPuk,
      "sim_apn": simApn,
      "sim_apn_user": simApnUser,
      "sim_apn_password": simApnPassword,
      "sim_iccid": simIccid,
      "updated_at": updatedAt?.toIso8601String(),
      "created_at": createdAt?.toIso8601String(),
      "vehicle_id": vehicleId,
      "channel_id": channelId,
      "user_id": userId,
      "id": id,
      "cid": cid,
      "installation": installation,
      "customer_id": customer?.id ?? customerId,
    };
  }
}
