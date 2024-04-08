import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../models/coin_model.dart';

class CryptoProvider extends ChangeNotifier {
  bool isRefreshing = true;

  late List<CoinModel> coinMarket = [];

  var coinMarketList;

  Future<List<CoinModel>?> getCoinMarket() async{
    const url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en';

    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type' : "application/json",
      "Accept" : "application/json",
    });

      isRefreshing = false;

    if(response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      coinMarket = coinMarketList;
    }else{
      print(response.statusCode);
    }
    return null;
  }
}