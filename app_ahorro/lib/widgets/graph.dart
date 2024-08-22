import 'package:fl_chart/fl_chart.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  const LineChartWidget({
    Key? key,
    required this.gradientColor1,
    required this.gradientColor2,
    required this.gradientColor3,
    required this.indicatorStrokeColor,
  }) : super(key: key);

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<int> showingTooltipOnSpots = [];
  List<FlSpot> allSpots = [];

  @override
  void initState() {
    super.initState();
    syncData();
  }

  Future<void> syncData() async {
    if (mounted) {  
    final ingresos = await DBHelper.queryIngresos();
    setState(() {
      allSpots = ingresos.asMap().entries.map((entry) {
        final index = entry.key.toDouble();
        final ingreso = entry.value.monto;
        return FlSpot(index, ingreso);
      }).toList();
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              widget.gradientColor1.withOpacity(0.4),
              widget.gradientColor2.withOpacity(0.4),
              widget.gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ],
          stops: const [0.1, 0.4, 0.9],
        ),
      ),
    ];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return LineChart(
              LineChartData(
                showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                  return ShowingTooltipIndicators([
                    LineBarSpot(
                      lineBarsData[0],
                      0,
                      lineBarsData[0].spots[index],
                    ),
                  ]);
                }).toList(),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      final spotIndex = response.lineBarSpots!.first.spotIndex;
                      setState(() {
                        if (showingTooltipOnSpots.contains(spotIndex)) {
                          showingTooltipOnSpots.remove(spotIndex);
                        } else {
                          showingTooltipOnSpots.add(spotIndex);
                        }
                      });
                    }
                  },
                  mouseCursorResolver: (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return SystemMouseCursors.basic;
                    }
                    return SystemMouseCursors.click;
                  },
                  getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        const FlLine(color: Colors.pink),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 8,
                            color: lerpGradient(
                              barData.gradient!.colors,
                              barData.gradient!.stops!,
                              percent / 100,
                            ),
                            strokeWidth: 2,
                            strokeColor: widget.indicatorStrokeColor,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.pink,
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                      return lineBarsSpot.map((lineBarSpot) {
                        return LineTooltipItem(
                          lineBarSpot.y.toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: lineBarsData,
                minY: 0,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    axisNameSize: 24,
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 0,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return bottomTitleWidgets(
                          value,
                          meta,
                          constraints.maxWidth,
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 0,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    axisNameWidget: Text(
                      'Ingresos',style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    axisNameSize: 24,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 0,
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: AppColors.borderColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double width) {
    const style = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      case 1:
        text = '2';
        break;
      case 2:
        text = '3';
        break;
      case 3:
        text = '4';
        break;
      case 4:
        text = '5';
        break;
      case 5:
        text = '6';
        break;
      case 6:
        text = '7';
        break;
        case 7:
        text = '8';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }
}
class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty || stops.isEmpty || colors.length != stops.length) {
    throw ArgumentError('Invalid gradient parameters');
  }

  for (int i = 0; i < stops.length - 1; i++) {
    if (t >= stops[i] && t <= stops[i + 1]) {
      final double localT = (t - stops[i]) / (stops[i + 1] - stops[i]);
      return Color.lerp(colors[i], colors[i + 1], localT)!;
    }
  }

  return colors.last;
}