import 'dart:ui';
import 'package:cripto/components/app_colors.dart';
import 'package:cripto/components/app_style.dart';
import 'package:cripto/ui/widgets/appbar_widget.dart';
import 'package:cripto/ui/widgets/card_widget.dart';
import 'package:cripto/ui/widgets/watch_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appDark,
        extendBody: true,
        body: FutureBuilder(
            future: context.watch<CryptoProvider>().getCoinMarket(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  color: AppColors.blackColor,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AppBarWidget(),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CardWidget(),
                              const SizedBox(height: 14),
                              const Text(
                                'WatchList',
                                style: AppStyle.titleStyle,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .5,
                                child: const WatchListWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
          onTap: () {},
          child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                    Color(0xff219653),
                    Color(0xff2F80ED),
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('assets/plus.png'),
              )),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 79,
              color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 65),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 36,
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/home.png'))),
                  ),
                  const Spacer(),
                  Container(
                    width: 26,
                    height: 36,
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/activity.png'))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
