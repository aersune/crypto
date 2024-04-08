import 'package:cripto/components/app_colors.dart';
import 'package:cripto/ui/widgets/item.dart';
import 'package:cripto/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../details_screen.dart';

class WatchListWidget extends StatelessWidget {
   const WatchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lisProv= context.watch<CryptoProvider>();
    final prov= context.read<CryptoProvider>();

    return
      ListView.separated(
      padding: const EdgeInsets.only(top: 14, bottom: 10),
      separatorBuilder: (context,i) => const SizedBox(height: 21,),
      shrinkWrap: true,
        itemCount: lisProv.coinMarket.length,
        itemBuilder: (context, index){
      return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailsScreen(coin: lisProv.coinMarket[index],)));
          },
          child: cryptoWidget(context, index, prov));
    });
  }


  Widget cryptoWidget(context, index, CryptoProvider provider) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.appDark,
      ),
      child: Item(item: provider.coinMarket[index],)
    );
  }
}
