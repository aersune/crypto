import 'package:cripto/components/app_colors.dart';
import 'package:cripto/components/app_style.dart';
import 'package:cripto/models/coin_model.dart';
import 'package:cripto/ui/widgets/icons_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    var rinkColor = coin.marketCapChangePercentage24H >= 0 ? AppColors.greenColor : AppColors.redColor;
    var formatter = NumberFormat('#,##,###.00');
    var isUp =  coin.marketCapChangePercentage24H >= 0;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Ink(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.appDark,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    )),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.network(
                        coin.image,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${coin.name} / USDT',
                      style: AppStyle.titleStyle,
                    )
                  ],
                ),
                IconsWidget().smallIcon(asset: 'assets/frame.png', bgColor: AppColors.appDark, size: 1),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: rinkColor),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatter.format(coin.currentPrice),
                      style: AppStyle.titleStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 32),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration:  BoxDecoration(image: DecorationImage(image: AssetImage(
                              coin.marketCapChangePercentage24H >= 0 ?
                              'assets/bulk_up.png' :
                              'assets/bulk_down.png'
                          ), fit: BoxFit.cover)),
                        ),
                        Text(
                          '${coin.priceChange24H.toStringAsFixed(2)}',
                          style: AppStyle.subTitleStyle.copyWith(color: rinkColor, fontSize: 13),
                        ),
                        Text(
                          '  (%${coin.marketCapChangePercentage24H.toStringAsFixed(2)})',
                          style: AppStyle.subTitleStyle.copyWith(color: rinkColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
