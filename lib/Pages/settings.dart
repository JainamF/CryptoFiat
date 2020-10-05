import 'package:currency/Model/currmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
  String current;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: Center(
          child: DropdownButton(
            value: current,
            items: currencyName.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (item) {
              setState(() {
                current = item;
              });
              Provider.of<CurrModel>(context, listen: false)
                  .changeBase(current);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
