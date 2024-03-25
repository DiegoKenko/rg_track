import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class MobileMovingStopCharts extends StatelessWidget {
  final int attention, ok, warning;

  const MobileMovingStopCharts({
    super.key,
    required this.attention,
    required this.ok,
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: DChartGauge(
        data: [
          {'domain': 'Normal', 'measure': ok},
          {'domain': 'Sem Comunicação', 'measure': warning},
          {'domain': 'Atenção', 'measure': attention},
        ],
        fillColor: (Map<String, dynamic> pieData, int? index) {
          switch (pieData['domain']) {
            case 'Atenção':
              return const Color(0xFFD2232A);
            case 'Normal':
              return const Color(0xFF009C6D);
            default:
              return const Color(0xFFEFAC00);
          }
        },
        showLabelLine: true,
        labelPosition: PieLabelPosition.outside,
        pieLabel: (Map pieData, int? index) {
          return '${pieData['domain']}: ${pieData['measure']}';
        },
      ),
    );
  }
}
