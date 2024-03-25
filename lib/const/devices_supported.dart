enum EnumBrand {
  // SunTech,
  X3Tech,
}

enum EnumModel {
  ST300Series,
  ST300R,
  ST310UC2,
  ST340UR,
  ST350,
  NT20,
  NT26,
}

extension BrandExtenstion on EnumBrand {
  String get description {
    switch (this) {
      /*  case EnumBrand.SunTech:
        return 'SunTech'; */
      case EnumBrand.X3Tech:
        return 'X3Tech';
      default:
        return '';
    }
  }

  List<EnumModel> get models {
    switch (this) {
      /*   case EnumBrand.SunTech:
        return [
          EnumModel.ST300Series,
          EnumModel.ST300R,
          EnumModel.ST310UC2,
          EnumModel.ST340UR,
          EnumModel.ST350,
        ]; */
      case EnumBrand.X3Tech:
        return [
          EnumModel.NT20,
          EnumModel.NT26,
        ];
      default:
        return [];
    }
  }

  int get flespiProtocolId {
    switch (this) {
      case EnumBrand.X3Tech:
        return 418;
      default:
        return 0;
    }
  }
}

extension ModelExtension on EnumModel {
  String get description {
    switch (this) {
      case EnumModel.ST300Series:
        return 'ST300 Series';
      case EnumModel.ST300R:
        return 'ST300R';
      case EnumModel.ST310UC2:
        return 'ST310UC2';
      case EnumModel.ST340UR:
        return 'ST340UR';
      case EnumModel.ST350:
        return 'ST350';
      case EnumModel.NT20:
        return 'NT20';
      case EnumModel.NT26:
        return 'NT26';
      default:
        return '';
    }
  }

  EnumBrand get brand {
    EnumBrand brandRet = EnumBrand.X3Tech;
    EnumBrand.values.map((e) {
      if (e.models.contains(this)) {
        brandRet = e;
      }
    }).toList();
    return brandRet;
  }

  int get flespiId {
    switch (this) {
      case EnumModel.ST300Series:
        return 422;
      case EnumModel.ST300R:
        return 424;
      case EnumModel.ST310UC2:
        return 418;
      case EnumModel.ST340UR:
        return 419;
      case EnumModel.NT20:
        return 2107;
      case EnumModel.NT26:
        return 2108;
      default:
        return 0;
    }
  }
}
