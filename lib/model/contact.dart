import 'package:ms_map_utils/ms_map_utils.dart';

class Contact {
  int? id;
  String email;
  String phone;
  String contactName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contact({
    this.id,
    required this.email,
    required this.phone,
    required this.contactName,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int,
      email: map['email'] ?? '' ?? '',
      phone: map['phone'] ?? '' ?? '',
      contactName: map['contact_name'] ?? '' ?? '',
      createdAt: map.doIfContains<DateTime>(
        'created_at',
        doWork: (key, value) => DateTime.parse(value),
      ),
      updatedAt: map.doIfContains<DateTime>(
        'updated_at',
        doWork: (key, value) => DateTime.parse(value),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'contact_name': contactName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
