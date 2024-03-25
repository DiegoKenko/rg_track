import 'package:flutter/material.dart';
import 'package:rg_track/const/colors_rgt.dart';
import 'package:rg_track/ui/dashboard/widget/dashboard_pie_chart.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class DashboardChartMobile extends StatelessWidget {
  final int attention, ok, warning;

  const DashboardChartMobile({
    super.key,
    required this.attention,
    required this.ok,
    required this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        Elevated(
          child: DashboardPieChart(
            attention: attention,
            ok: ok,
            warning: warning,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Elevated(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsRgt.error,
            ),
            padding: const EdgeInsets.all(10),
            height: 50,
            child: Row(
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
        Elevated(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsRgt.success,
            ),
            height: 50,
            child: Row(
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
        Elevated(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsRgt.warning,
            ),
            padding: const EdgeInsets.all(10),
            height: 50,
            child: Row(
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
