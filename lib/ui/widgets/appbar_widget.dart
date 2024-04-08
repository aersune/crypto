import 'package:cripto/components/app_colors.dart';
import 'package:cripto/components/app_style.dart';
import 'package:cripto/ui/widgets/icons_widget.dart';
import 'package:cripto/ui/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      color: AppColors.appDark,
      height: 176,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .02,
          ),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://www.vhv.rs/dpng/d/426-4263064_circle-avatar-png-picture-circle-avatar-image-png.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.redColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 12),),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back' , style: AppStyle.subTitleStyle.copyWith(color: AppColors.subTitleColor),),
                  const Text('aersune' , style: AppStyle.titleStyle,),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  IconsWidget().smallIcon(asset:  'assets/wallet.png'),
                  const SizedBox(width: 10),
                  IconsWidget().smallIcon(asset: 'assets/scaner.png'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SearchBarWidget(),
        ],
      ),
    );
  }

}
