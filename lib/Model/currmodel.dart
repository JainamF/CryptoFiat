import 'package:currency/Data/curr.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class CurrModel extends ChangeNotifier {
  List<Curr> currList = List();
  List<String> cName, cPrice;
  String currentBase = 'INR';
  Map<String, String> cry = {
    'BTC': 'bitcoin',
    'ETH': 'ethereum',
    'LTC': 'litecoin',
    'BCH': 'bitcoin-cash',
    'BNB': 'binancecoin',
    'EOS': 'eos',
    'XRP': 'ripple',
    'XLM': 'stellar',
    'LINK': 'chainlink',
    'DOT': 'polkadot',
    'YFI': 'yearn-finance',
  };

  changeBase(String base) {
    currentBase = base;
    if (currList.isEmpty) {
      return;
    } else {
      List<String> demo = List();
      currList.forEach((element) {
        demo.add(element.name);
      });
      currList.clear();
      demo.forEach((element) {
        if (cry.containsValue(element)) {
          fetchCrypto(element);
        } else {
          fetchFiat(element);
        }
      });
    }
    notifyListeners();
  }

  fetchCrypto(String toName) async {
    String cryptname = toName;
    cry.forEach((key, value) {
      if (toName == key) {
        cryptname = value;
      }
    });
    String cryurl =
        'https://api.coingecko.com/api/v3/simple/price?ids=$cryptname&vs_currencies=$currentBase';
    http.Response cryresp = await http.get(cryurl);
    var crydata = json.decode(cryresp.body);
    Map<String, dynamic> cryp = crydata[cryptname];
    dynamic pricelist = cryp.values.toList();
    currList.add(Curr(cryptname, pricelist[0]));
    notifyListeners();
  }

  fetchFiat(String toName) async {
    String apiurl = 'https://api.exchangeratesapi.io/latest?base=$currentBase';
    http.Response response = await http.get(apiurl);
    var data = json.decode(response.body);
    Map<String, dynamic> curr = data["rates"];
    curr.forEach((key, value) {
      if (toName == key.toString() && !currList.contains(Curr(key, value))) {
        currList.add(Curr(key, value));
      }
    });
    notifyListeners();
  }
}
