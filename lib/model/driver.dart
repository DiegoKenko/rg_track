import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:rg_track/model/address.dart';
import 'package:rg_track/model/contact.dart';
import 'package:rg_track/model/customer.dart';

class Driver {
  Driver({
    this.id,
    this.customerId,
    this.customer,
    this.name,
    this.document,
    this.rg,
    this.cnh,
    this.cnhCategory,
    this.cnhFirstEnablement,
    this.cnhExpiresAt,
    this.gender,
    this.maritalState,
    this.birthday,
    this.status = 'active',
    this.servicePassword,
    this.indication,
    this.phone,
    this.mobilePhone,
    this.isWhatsapp,
    this.email,
    this.secretQuestion,
    this.secretAnswer,
    this.driverCode,
    this.observations,
    this.startsWorkAt,
    this.endsWorkAt,
    this.lunchStartsAt,
    this.lunchStopsAt,
    this.updatedAt,
    this.createdAt,
    List<Contact>? contacts,
    List<Address>? addresses,
  })  : contacts = contacts ?? [],
        addresses = addresses ?? [];

  int? id;
  String? customerId;
  Customer? customer;
  String? name;
  String? document;
  String? rg;
  String? cnh;
  String? cnhCategory;
  DateTime? cnhExpiresAt;
  DateTime? cnhFirstEnablement;
  String? gender;
  String? maritalState;
  DateTime? birthday;
  String? status;
  String? servicePassword;
  String? indication;
  String? phone;
  String? mobilePhone;
  bool? isWhatsapp;
  String? email;
  String? secretQuestion;
  String? secretAnswer;
  String? driverCode;
  String? observations;
  String? startsWorkAt;
  String? endsWorkAt;
  String? lunchStartsAt;
  String? lunchStopsAt;
  DateTime? updatedAt;
  DateTime? createdAt;
  List<Contact> contacts;
  List<Address> addresses;

  String get title => "$name - ($documentObfuscated)";

  String get documentObfuscated =>
      "${document?.substring(0, 3)}.***.**${document?[8]}-${document?.substring(9)}";

  Driver copyWith({
    int? id,
    String? customerId,
    Customer? customer,
    String? name,
    String? document,
    String? rg,
    String? cnh,
    DateTime? cnhExpiresAt,
    String? gender,
    String? maritalState,
    DateTime? birthday,
    String? status,
    String? servicePassword,
    String? indication,
    String? phone,
    String? mobilePhone,
    bool? isWhatsapp,
    String? email,
    String? secretQuestion,
    String? secretAnswer,
    String? driverCode,
    String? observations,
    String? startsWorkAt,
    String? endsWorkAt,
    String? lunchStartsAt,
    String? lunchStopsAt,
    DateTime? updatedAt,
    DateTime? createdAt,
    List<Contact>? contacts,
    List<Address>? addresses,
  }) =>
      Driver(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        customer: customer ?? this.customer,
        name: name ?? this.name,
        document: document ?? this.document,
        rg: rg ?? this.rg,
        cnh: cnh ?? this.cnh,
        cnhExpiresAt: cnhExpiresAt ?? this.cnhExpiresAt,
        gender: gender ?? this.gender,
        maritalState: maritalState ?? this.maritalState,
        birthday: birthday ?? this.birthday,
        status: status ?? this.status,
        servicePassword: servicePassword ?? this.servicePassword,
        indication: indication ?? this.indication,
        phone: phone ?? this.phone,
        mobilePhone: mobilePhone ?? this.mobilePhone,
        isWhatsapp: isWhatsapp ?? this.isWhatsapp,
        email: email ?? this.email,
        secretQuestion: secretQuestion ?? this.secretQuestion,
        secretAnswer: secretAnswer ?? this.secretAnswer,
        driverCode: driverCode ?? this.driverCode,
        observations: observations ?? this.observations,
        startsWorkAt: startsWorkAt ?? this.startsWorkAt,
        endsWorkAt: endsWorkAt ?? this.endsWorkAt,
        lunchStartsAt: lunchStartsAt ?? this.lunchStartsAt,
        lunchStopsAt: lunchStopsAt ?? this.lunchStopsAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        contacts: contacts ?? this.contacts,
        addresses: addresses ?? this.addresses,
      );

  factory Driver.fromMap(Map<String, dynamic> json) => Driver(
        id: json["id"],
        customerId: json["customer_id"],
        customer: doIfContains(
          json,
          'customer',
          doWork: (key, value) => Customer.fromMap(value),
        ),
        name: json["name"],
        document: json["document"],
        rg: json["rg"],
        cnh: json["cnh"],
        cnhCategory: json["cnh_category"],
        cnhExpiresAt: DateTime.parse(json["cnh_expires_at"]),
        cnhFirstEnablement: DateTime.parse(json["cnh_first_enablement"]),
        gender: json["gender"],
        maritalState: json["marital_state"],
        birthday: DateTime.parse(json["birthday"]),
        status: json["status"],
        servicePassword: json["service_password"],
        indication: json["indication"],
        phone: json["phone"],
        mobilePhone: json["mobile_phone"],
        isWhatsapp: json["is_whatsapp"],
        email: json["email"],
        secretQuestion: json["secret_question"],
        secretAnswer: json["secret_answer"],
        driverCode: json["driver_code"],
        observations: json["observations"],
        startsWorkAt: json["starts_work_at"],
        endsWorkAt: json["ends_work_at"],
        lunchStartsAt: json["lunch_starts_at"],
        lunchStopsAt: json["lunch_stops_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        contacts: json.doIfContains(
          "contacts",
          doWork: (key, value) => value.map((e) => Contact.fromMap(e)).toList(),
        ),
        addresses: json.doIfContains(
          "addresses",
          doWork: (key, value) => value.map((e) => Address.fromMap(e)).toList(),
        ),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "customer_id": customerId,
        "name": name,
        "document": document,
        "rg": rg,
        "cnh": cnh,
        "cnh_category": cnhCategory,
        "cnh_expires_at": cnhExpiresAt?.toIso8601String(),
        "cnh_first_enablement": cnhFirstEnablement?.toIso8601String(),
        "gender": gender,
        "marital_state": maritalState,
        "birthday": birthday?.toIso8601String(),
        "status": status,
        "service_password": servicePassword,
        "indication": indication,
        "phone": phone,
        "mobile_phone": mobilePhone,
        "is_whatsapp": isWhatsapp,
        "email": email,
        "secret_question": secretQuestion,
        "secret_answer": secretAnswer,
        "driver_code": driverCode,
        "observations": observations,
        "starts_work_at": startsWorkAt,
        "ends_work_at": endsWorkAt,
        "lunch_starts_at": lunchStartsAt,
        "lunch_stops_at": lunchStopsAt,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "contacts": contacts.map((Contact e) => e.toMap()).toString(),
        "addresses": addresses.map((Address e) => e.toMap()).toString(),
      };
}
