import 'package:flutter/material.dart';
import 'package:rg_track/const/colors_rgt.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class DashboardChartWide extends StatelessWidget {
  final int attention, ok, warning;

  const DashboardChartWide({
    super.key,
    required this.attention,
    required this.ok,
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Elevated(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsRgt.error,
            ),
            padding: const EdgeInsets.all(4),
            width: 232,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
        const SizedBox(
          height: 5,
        ),
        Elevated(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsRgt.success,
            ),
            width: 232,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Veículos com comunicação normal',
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
        ),
        const SizedBox(
          height: 5,
        ),
        Elevated(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsRgt.warning,
            ),
            padding: const EdgeInsets.all(4),
            width: 232,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ],
    );
  }
}
