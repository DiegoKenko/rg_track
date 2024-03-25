class FineAlert {
  int? id;
  String? status;
  int? vehicleKindId;
  String? licensePlate;
  String? color;
  String? renavam;
  String? manufacturer;
  String? model;
  String? year;
  String? chassi;
  String? uf;
  String? observations;
  String? fleet;
  bool? fineConsultation;
  DateTime? updatedAt;
  DateTime? createdAt;

  FineAlert({
    this.id,
    this.status,
    this.vehicleKindId,
    this.licensePlate,
    this.color,
    this.renavam,
    this.manufacturer,
    this.model,
    this.year,
    this.chassi,
    this.uf,
    this.observations,
    this.fleet,
    this.fineConsultation,
    this.updatedAt,
    this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FineAlert &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          vehicleKindId == other.vehicleKindId &&
          licensePlate == other.licensePlate &&
          color == other.color &&
          renavam == other.renavam &&
          manufacturer == other.manufacturer &&
          model == other.model &&
          year == other.year &&
          chassi == other.chassi &&
          uf == other.uf &&
          observations == other.observations &&
          fleet == other.fleet &&
          fineConsultation == other.fineConsultation &&
          updatedAt == other.updatedAt &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^
      status.hashCode ^
      vehicleKindId.hashCode ^
      licensePlate.hashCode ^
      color.hashCode ^
      renavam.hashCode ^
      manufacturer.hashCode ^
      model.hashCode ^
      year.hashCode ^
      chassi.hashCode ^
      uf.hashCode ^
      observations.hashCode ^
      fleet.hashCode ^
      fineConsultation.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'FineAlert{'
        ' id: $id,'
        ' status: $status,'
        ' vehicleKindId: $vehicleKindId,'
        ' licensePlate: $licensePlate,'
        ' color: $color,'
        ' renavam: $renavam,'
        ' manufacturer: $manufacturer,'
        ' model: $model,'
        ' year: $year,'
        ' chassi: $chassi,'
        ' uf: $uf,'
        ' observations: $observations,'
        ' fleet: $fleet,'
        ' fineConsultation: $fineConsultation,'
        ' updatedAt: $updatedAt,'
        ' createdAt: $createdAt,'
        '}';
  }

  FineAlert copyWith({
    int? id,
    String? status,
    int? vehicleKindId,
    String? licensePlate,
    String? color,
    String? renavam,
    String? manufacturer,
    String? model,
    String? year,
    String? chassi,
    String? uf,
    String? observations,
    String? fleet,
    bool? fineConsultation,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return FineAlert(
      id: id ?? this.id,
      status: status ?? this.status,
      vehicleKindId: vehicleKindId ?? this.vehicleKindId,
      licensePlate: licensePlate ?? this.licensePlate,
      color: color ?? this.color,
      renavam: renavam ?? this.renavam,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      year: year ?? this.year,
      chassi: chassi ?? this.chassi,
      uf: uf ?? this.uf,
      observations: observations ?? this.observations,
      fleet: fleet ?? this.fleet,
      fineConsultation: fineConsultation ?? this.fineConsultation,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'vehicleKindId': vehicleKindId,
      'licensePlate': licensePlate,
      'color': color,
      'renavam': renavam,
      'manufacturer': manufacturer,
      'model': model,
      'year': year,
      'chassi': chassi,
      'uf': uf,
      'observations': observations,
      'fleet': fleet,
      'fineConsultation': fineConsultation,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory FineAlert.fromMap(Map<String, dynamic> map) {
    return FineAlert(
      id: map['id'] as int,
      status: map['status'] ?? '',
      vehicleKindId: map['vehicleKindId'] as int,
      licensePlate: map['licensePlate'] ?? '',
      color: map['color'] ?? '',
      renavam: map['renavam'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? '',
      chassi: map['chassi'] ?? '',
      uf: map['uf'] ?? '',
      observations: map['observations'] ?? '',
      fleet: map['fleet'] ?? '',
      fineConsultation: map['fineConsultation'] as bool,
      updatedAt: map['updatedAt'] as DateTime,
      createdAt: map['createdAt'] as DateTime,
    );
  }
}
