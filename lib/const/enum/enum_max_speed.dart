import 'package:rg_track/service/flespi/flespi_base.dart';

enum EnumMaxSpeed { maxSpeed60, maxSpeed80, maxSpeed100 }

extension MaxSpeedCalc on EnumMaxSpeed {
  int get calcId {
    switch (this) {
      case EnumMaxSpeed.maxSpeed60:
        return flespiCalcMaxSpeed60;
      case EnumMaxSpeed.maxSpeed80:
        return flespiCalcMaxSpeed80;
      case EnumMaxSpeed.maxSpeed100:
        return flespiCalcMaxSpeed100;
      default:
        return flespiCalcMaxSpeed60;
    }
  }

  int get speed {
    switch (this) {
      case EnumMaxSpeed.maxSpeed60:
        return 60;
      case EnumMaxSpeed.maxSpeed80:
        return 80;
      case EnumMaxSpeed.maxSpeed100:
        return 100;
      default:
        return 60;
    }
  }
}
