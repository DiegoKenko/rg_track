import 'package:flutter/material.dart';
import 'package:rg_track/const/colors_rgt.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPieChart extends StatelessWidget {
  const DashboardPieChart({
    super.key,
    required this.attention,
    required this.ok,
    required this.warning,
  });
  final int attention, ok, warning;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      palette: const [
        ColorsRgt.error,
        ColorsRgt.success,
        ColorsRgt.warning,
      ],
      borderWidth: 1,
      series: <CircularSeries<_ChartData, String>>[
        DoughnutSeries<_ChartData, String>(
            dataSource: [
              _ChartData(attention),
              _ChartData(ok),
              _ChartData(warning)
            ],
            xValueMapper: (_ChartData data, _) => data.ammount.toString(),
            yValueMapper: (_ChartData data, _) => data.ammount,
            name: 'Gold'),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.ammount);
  final int ammount;
}
