import 'package:cripto/components/app_colors.dart';
import 'package:cripto/components/app_style.dart';
import 'package:cripto/provider/provider.dart';
import 'package:cripto/ui/widgets/details_appbar.dart';
import 'package:cripto/ui/widgets/watch_list_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/coin_model.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, required this.coin});
  final CoinModel coin;

  final List<Color> gradienColors = [AppColors.greenColor, AppColors.greenColor.withOpacity(0.0)];

  @override
  Widget build(BuildContext context) {
    var item = context.read<CryptoProvider>().coinMarket.last;
    var list = item.sparklineIn7D.price.sublist(item.sparklineIn7D.price.length - 28);

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DetailsAppBar(coin: coin),
          const SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  timeTextWidget(text: '24H'),
                  timeTextWidget(text: '1W', isActive: true),
                  timeTextWidget(text: '1M'),
                  timeTextWidget(text: '1M'),
                  timeTextWidget(text: 'All'),
              ],
            ),
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 263,
            width: MediaQuery.of(context).size.width * .9,
            child: LineChart(LineChartData(
                minX: 0,
                maxX: 8,
                minY: 0,
                maxY: 5,
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: leftTitleWidgets,
                      reservedSize: 29,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (val) {
                    return const FlLine(color: Color(0xff525766), strokeWidth: 1);
                  },
                  drawVerticalLine: true,
                  getDrawingVerticalLine: (val) {
                    return const FlLine(color: Color(0xff525766), strokeWidth: 1);
                  },
                ),
                borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff525766), width: 1)),
                lineBarsData: [
                  LineChartBarData(
                      spots: [
                        const FlSpot(0, 1),
                        const FlSpot(1.6, 2),
                        const FlSpot(3.9, 4.5),
                        const FlSpot(5, 3.1),
                        const FlSpot(6.3, 4),
                        const FlSpot(7, 3),
                        const FlSpot(8, 4),
                      ],
                      color: AppColors.greenColor,
                      isCurved: true,
                      barWidth: 1.76,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: gradienColors),
                      ))
                ])),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonsWidget(AppColors.greenColor, 'Buy'),
                buttonsWidget(AppColors.redColor, 'Sell'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quick watch', style: AppStyle.subTitleStyle.copyWith(fontSize: 15, color: AppColors.grayColor),),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('See All', style: AppStyle.subTitleStyle.copyWith(fontSize: 15, color: AppColors.grayColor),),
                    const SizedBox(width: 9,),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.grayColor, size: 13,)
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric( horizontal: 24 ),
              height: MediaQuery.of(context).size.height * .27,
              child:  const WatchListWidget()),
        ],
      ),
    );
  }
}

Widget buttonsWidget(Color color, String text){
  return Container(
    width: 135,
    height: 45,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
    child: Center(
      child: Text(
        text, style: AppStyle.titleStyle,),
    ),
  );
}

Widget timeTextWidget({required String text, bool isActive = false}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: isActive ? AppColors.appDark : Colors.transparent,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Text(text, style: AppStyle.subTitleStyle.copyWith(color: Colors.white),),
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta)  {
  const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.subTitleColor);
  const subtitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.grayColor);
  Widget text;
  var days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', "Mon"];
  var nums = [15, 16, 17, 18, 19, 20, 21, 22];

  int index = value.toInt() - 1;

  if (index < 0 || index >= days.length) {
    text = const Text('');
  } else {
    text = Column(
      children: [
        Text(days[index], style: style),
        Text('${nums[index]}', style: subtitle),
      ],
    );
  }

  return SideTitleWidget(
    space: 5,
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.subTitleColor);
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0K';
      break;
    case 1:
      text = '1K';
      break;
    case 2:
      text = '2k';
      break;
    case 3:
      text = '3k';
      break;
    case 4:
      text = '4k';
      break;
    case 5:
      text = '5k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
