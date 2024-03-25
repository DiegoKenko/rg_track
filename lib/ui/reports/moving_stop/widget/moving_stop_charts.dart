import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class MovingStopCharts extends StatelessWidget {
  final int attention, ok, warning;

  const MovingStopCharts({
    super.key,
    required this.attention,
    required this.ok,
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        SizedBox(
          height: 120,
          width: 150,
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
            showLabelLine: false,
            pieLabel: (Map pieData, int? index) {
              return "";
            },
          ),
        ),
        Container(
          color: const Color(0xFFD2232A),
          padding: const EdgeInsets.all(4),
          width: 232,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Veículos que precisam de atenção',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$attention',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFF009C6D),
          padding: const EdgeInsets.all(4),
          width: 232,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Veículos comunicação normal',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$ok',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFFEFAC00),
          padding: const EdgeInsets.all(4),
          width: 232,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Veículos parados há mais de 24 horas',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$warning',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
