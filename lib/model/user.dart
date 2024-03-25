import 'package:ms_map_utils/ms_map_utils.dart';

import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/permissions.dart';

class UserEntity {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? document;
  bool isWhatsApp;
  DateTime? emailVerifiedAt;
  DateTime? phoneVerifiedAt;
  String? startOfTheJourney;
  String? endOfTheJourney;
  String? status;
  String? kind;
  String? parentId;

  DateTime? birthday;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? notificationToken;
  String? customer;
  bool rememberSession;
  List<Permission>? abilities;

  String get password => id?.substring(0, 8) ?? '12345678';

  String get statusFormatted =>
      status?.toLowerCase() == 'active' ? 'ATIVO' : 'INATIVO';

  String get simpleID => id?.substring(0, 8) ?? '';

  bool get authorized => id != null;

  UserEntity.commom({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.birthday,
    this.customer,
    this.document,
    this.parentId,
    this.isWhatsApp = false,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.startOfTheJourney,
    this.endOfTheJourney,
    this.status = 'active',
    this.kind = 'userEntity',
    this.createdAt,
    this.updatedAt,
    this.notificationToken,
    this.rememberSession = false,
  }) : abilities = Permission.values;

  UserEntity.login({
    required this.email,
    required this.id,
    this.parentId,
    this.notificationToken,
    this.rememberSession = false,
  })  : isWhatsApp = false,
        kind = 'userEntity',
        name = null,
        phone = null,
        document = null,
        emailVerifiedAt = null,
        phoneVerifiedAt = null,
        startOfTheJourney = null,
        endOfTheJourney = null,
        status = null,
        createdAt = null,
        updatedAt = null,
        abilities = Permission.values;

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    UserEntity user = UserEntity.commom(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      parentId: map['parent_id'],
      document: map['document'],
      startOfTheJourney: map['start_of_the_journey'],
      endOfTheJourney: map['end_of_the_journey'],
      status: map['status'],
      isWhatsApp: map['is_whatsapp'] as bool? ?? false,
      emailVerifiedAt: map.doIfContains<DateTime?>(
        'email_verified_at',
        doWork: (key, value) => DateTime.tryParse(value ?? ''),
      ),
      phoneVerifiedAt: map.doIfContains<DateTime?>(
        'phone_verified_at',
        doWork: (key, value) => DateTime.tryParse(value ?? ''),
      ),
      kind: map['kind'],
      createdAt: map.doIfContains<DateTime?>(
        'created_at',
        doWork: (key, value) => DateTime.tryParse(value ?? ''),
      ),
      updatedAt: map.doIfContains<DateTime?>(
        'updated_at',
        doWork: (key, value) => DateTime.tryParse(value ?? ''),
      ),
      notificationToken: map['notificationToken'],
    );
    user = user.copyWith(
      abilities: ((map['abilities'] ?? []) as List).map((e) {
        return Permission.values
            .firstWhere((element) => element.permission == e);
      }).toList(),
    );
    return user;
  }

  Map<String, dynamic> get loginData => {
        'login': email ?? phone ?? document,
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'parent_id': parentId,
      'document': document,
      'is_whatsapp': isWhatsApp,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'phone_verified_at': phoneVerifiedAt?.toIso8601String(),
      'start_of_the_journey': startOfTheJourney,
      'end_of_the_journey': endOfTheJourney,
      'status': status,
      'kind': kind,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'notificationToken': notificationToken,
      'remember_session': rememberSession,
      'abilities': abilities?.map((e) => e.permission).toList(),
    };
  }

  bool can(Permission permission) {
    if (kind == 'admin') return true;
    if (abilities == null) return false;
    return abilities?.contains(permission) ?? false;
  }

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? parentId,
    String? document,
    bool? isWhatsApp,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    String? startOfTheJourney,
    String? endOfTheJourney,
    String? status,
    String? kind,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notificationToken,
    bool? rememberSession,
    Customer? customer,
    List<Permission>? abilities,
  }) {
    return UserEntity.commom(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      parentId: parentId ?? this.parentId,
      document: document ?? this.document,
      isWhatsApp: isWhatsApp ?? this.isWhatsApp,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      startOfTheJourney: startOfTheJourney ?? this.startOfTheJourney,
      endOfTheJourney: endOfTheJourney ?? this.endOfTheJourney,
      status: status ?? this.status,
      kind: kind ?? this.kind,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notificationToken: notificationToken ?? this.notificationToken,
      rememberSession: rememberSession ?? this.rememberSession,
    );
  }
}
