import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/coin_model.dart';
import '../../components/app_colors.dart';
import '../../components/app_style.dart';

class Item extends StatelessWidget {
  CoinModel item;

  Item({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var rinkColor = item.marketCapChangePercentage24H >= 0 ? AppColors.greenColor : AppColors.redColor;
    var isUp =  item.marketCapChangePercentage24H >= 0;
    var formatter = NumberFormat('#,##,###.00');

    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: const Color(0xffFF971A),
              image: DecorationImage(image: NetworkImage(item.image), fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.name,
              style: AppStyle.titleStyle,
            ),
            Text(
              item.symbol.toUpperCase(),
              style: AppStyle.subTitleStyle,
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: size.width * .2,
          height: 45,
          child: Sparkline(
            data: item.sparklineIn7D.price.sublist(item.sparklineIn7D.price.length - 28),
            lineWidth: 1,
            lineColor: rinkColor,
            fillMode: FillMode.below,
            fillGradient: LinearGradient(
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter,
                colors: [rinkColor, rinkColor.withOpacity(0.0)]),
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              formatter.format(item.currentPrice),
              style: AppStyle.titleStyle,
            ),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration:  BoxDecoration(image: DecorationImage(image: AssetImage(
                      item.marketCapChangePercentage24H >= 0 ?
                      'assets/bulk_up.png' :
                      'assets/bulk_down.png'
                  ), fit: BoxFit.cover)),
                ),
                Text(
                  '${isUp ? '+' : ''}${item.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                  style: AppStyle.subTitleStyle.copyWith(color: rinkColor, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
