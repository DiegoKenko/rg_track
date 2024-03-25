import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:rg_track/model/contact.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/model/user.dart';

class Customer extends UserEntity {
  Customer({
    required String userParentId,
    super.id,
    super.name,
    super.email,
    super.phone,
    super.document,
    super.isWhatsApp,
    super.emailVerifiedAt,
    super.phoneVerifiedAt,
    super.startOfTheJourney,
    super.endOfTheJourney,
    super.status = null,
    super.kind = null,
    super.createdAt,
    super.updatedAt,
    super.notificationToken,
    super.rememberSession = true,
    List<Permission>? abilities,
    this.fantasyName,
    this.fullName,
    this.socialName,
    this.customerParent,
  }) : super.commom(
          parentId: userParentId,
        );

  List<Contact>? contacts;
  Customer? customerParent;
  String? gender;
  String? fullName;
  String? socialName;
  String? fantasyName;

  @override
  String get simpleID => id?.substring(0, 6) ?? '';

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      userParentId: map['parent_id'],
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
  }

  String get bestName => fullName ?? fantasyName ?? socialName ?? '';

  String get bestPhoneNumber => phone ?? contacts?.firstOrNull?.phone ?? '';

  @override
  Map<String, dynamic> toMap() {
    return compact({
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
    });
  }

  @override
  Customer copyWith({
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
    return Customer(
      userParentId: parentId ?? this.parentId ?? '',
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
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
