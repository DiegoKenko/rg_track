import 'package:result_dart/result_dart.dart';
import 'package:rg_track/const/enum/enum_max_speed.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/flespi/device/calculator/cut_power/flespi_service_calc_cut_power.dart';
import 'package:rg_track/service/flespi/device/calculator/max_speed/flespi_service_calc_max_speed.dart';

class LoadEventsUseCase {
  final FlespiServiceCalculatorMaxSpeed flespiServiceCalculatorMaxSpeed =
      FlespiServiceCalculatorMaxSpeed();
  final FlespiServiceCalcCutPower flespiServiceCalcCutPower =
      FlespiServiceCalcCutPower();

  Future<List<Event>> load(Vehicle vehicle) async {
    List<Event> events = [];
    if (vehicle.id == null) {
      return events;
    }
    await flespiServiceCalculatorMaxSpeed
        .getMaxsSpeed(
            vehicle.deviceMainId!, vehicle.maxSpeed ?? EnumMaxSpeed.maxSpeed60)
        .fold((success) {
      for (var flespiCalc in success) {
        events.add(Event.fromFlespiCalcMaxSpeed(vehicle, flespiCalc));
      }
    }, (error) => null);

    await flespiServiceCalcCutPower.call(vehicle.deviceMainId!).fold((success) {
      for (var flespiCalc in success) {
        events.add(Event.fromFlespiCalcCutPower(vehicle, flespiCalc));
      }
    }, (error) => null);

    return events;
  }
}
