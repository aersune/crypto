import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:cripto/components/app_colors.dart';
import 'package:cripto/components/app_style.dart';
import 'package:cripto/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/coin_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prov = context.read<CryptoProvider>();
    CoinModel coin = prov.coinMarket.first;
    Color rinkColor = coin.marketCapChangePercentage24H >= 0 ? AppColors.greenColor : AppColors.redColor;



    return Container(
      width: size.width,
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          AppColors.gradientGreen,
          AppColors.gradientBlue,
        ]),
      ),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.gradientBg.withOpacity(.8),
            ),
            child: Stack(
              children: [
                Align(alignment: Alignment.bottomLeft, child: vectorWidget('assets/bottom_vektor.png')),
                Align(alignment: Alignment.topRight, child: vectorWidget('assets/top_vektor.png')),
                Align(
                  alignment: Alignment.topLeft,
                  child: textCard(prov, rinkColor),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 19, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24,     bottom: 15),
                          child: SizedBox(
                            width: size.width * .2,
                            height: 45,
                            child: Sparkline(


                              data: coin.sparklineIn7D.price.sublist(coin.sparklineIn7D.price.length - 28),
                              lineWidth: 1,
                              lineColor: rinkColor,
                              fillMode: FillMode.below,
                              fillGradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end:Alignment.bottomCenter,
                                  colors: [rinkColor, rinkColor.withOpacity(0.0)]),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width / 1.25,
                          height: 1,
                          decoration:  const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.transparent,
                               Color(0xff192330),

                               Color(0x0fffffff),
                               Color(0x0fffffff),

                               Color(0xff192330),
                                  Colors.transparent,
                            ])
                          ),
                        ),
                        const SizedBox(height: 8),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textCard(CryptoProvider provider, Color color) {
    CoinModel coin = provider.coinMarket.first;
    var formatter = NumberFormat('#,##,###.00');
    var isUp =  coin.marketCapChangePercentage24H >= 0;
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Portfolio value',
            style: AppStyle.titleStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${formatter.format(coin.currentPrice)}',
            style: AppStyle.titleStyle.copyWith(fontSize: 24),
          ),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/bulk_up.png'), fit: BoxFit.cover)),
              ),
              Text(
                '\$${formatter.format(coin.currentPrice)}(${isUp ? '+' : ''}${coin.marketCapChangePercentage24H.toStringAsFixed(2)})',
                style: AppStyle.subTitleStyle.copyWith(color: color, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget vectorWidget(String asset) {
    return Container(
      width: 43,
      height: 67,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(asset), fit: BoxFit.cover)),
    );
  }
}
