class Peripheral {
  int? id;
  String? brand;
  String? model;
  String? serial;
  String? observations;
  DateTime? createdAt, updatedAt;

  Peripheral({
    this.id,
    this.brand,
    this.model,
    this.serial,
    this.observations,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'serial': serial,
      'observations': observations,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String get title => "$brand - $model";

  factory Peripheral.fromMap(Map<String, dynamic> map) {
    return Peripheral(
      id: map['id'] as int,
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      serial: map['serial'] ?? '',
      observations: map['observations'] ?? '',
      createdAt: map['created_at'] as DateTime,
      updatedAt: map['updated_at'] as DateTime,
    );
  }
}
