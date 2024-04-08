import 'package:cripto/components/app_colors.dart';
import 'package:cripto/components/app_style.dart';
import 'package:cripto/ui/widgets/icons_widget.dart';
import 'package:flutter/material.dart';


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)
          ),
          fillColor: AppColors.blackColor,
          filled: true,
          isDense: true,
          hintText: 'Search...',
          hintStyle: AppStyle.subTitleStyle.copyWith(color: AppColors.subTitleColor.withOpacity(0.4)),
          prefixIcon:  const Padding(
            padding:  EdgeInsets.all(10.0),
            child:  ImageIcon(AssetImage('assets/search.png'),size: 20, color: Colors.white,),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: IconsWidget().smallIcon(asset: 'assets/filter.png', bgColor: AppColors.appDark),
          )
        ),
      ),
    );
  }
}
