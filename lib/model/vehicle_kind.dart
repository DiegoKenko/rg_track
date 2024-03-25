enum VehicleKind {
  moto,
  carro,
  caminhao,
}

extension VehicleName on VehicleKind {
  String get name {
    switch (this) {
      case VehicleKind.moto:
        return 'Moto';
      case VehicleKind.carro:
        return 'Carro';
      case VehicleKind.caminhao:
        return 'Caminhão';
      default:
        return '';
    }
  }

  String get description {
    switch (this) {
      case VehicleKind.moto:
        return 'moto';
      case VehicleKind.carro:
        return 'carro';
      case VehicleKind.caminhao:
        return 'caminhao';
      default:
        return '';
    }
  }
}
