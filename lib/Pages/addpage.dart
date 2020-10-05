import 'package:currency/Model/currmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<String> currencyName = [
    'EUR',
    'HKD',
    'CAD',
    'CHF',
    'NOK',
    'ILS',
    'USD',
    'KRW',
    'DKK',
    'SEK',
    'JPY',
    'GBP',
    'AUD',
    'HUF',
    'BRL',
    'ZAR',
    'PLN',
    'RUB',
    'THB',
    'CZK',
    'IDR',
    'SGD',
    'INR',
    'MXN',
    'TRY',
    'MYR',
    'CNY',
    'NZD',
    'PHP',
  ];

  List<String> cryptoName = [
    'BTC',
    'ETH',
    'LTC',
    'BCH',
    'BNB',
    'EOS',
    'XRP',
    'XLM',
    'LINK',
    'DOT',
    'YFI',
  ];

  TextEditingController _inputText;
  String from, to;
  List<String> items = List();

  @override
  void initState() {
    items.addAll(currencyName);
    items.addAll(cryptoName);
    super.initState();
  }

  void filterResult(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(currencyName);
    dummySearchList.addAll(cryptoName);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(currencyName);
        items.addAll(cryptoName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          style: TextStyle(color: Colors.white),
          autofocus: true,
          controller: _inputText,
          onChanged: (value) => filterResult(value),
          decoration: InputDecoration(
            hintText: 'Search',
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text(() {
                if (currencyName.contains(items[index])) {
                  return 'Fiat';
                } else {
                  return 'Crypto';
                }
              }()),
              title: Text('${items[index]}'),
              trailing: FlatButton(
                color: Colors.blue[100],
                onPressed: () {
                  if (currencyName.contains(items[index])) {
                    Provider.of<CurrModel>(context, listen: false)
                        .fetchFiat(items[index]);
                    Navigator.pop(context);
                  } else {
                    Provider.of<CurrModel>(context, listen: false)
                        .fetchCrypto(items[index]);
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              ),
            );
          },
        ),
      ),
    );
  }
}
