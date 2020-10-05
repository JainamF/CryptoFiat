import 'package:currency/Pages/addpage.dart';
import 'package:currency/Model/currmodel.dart';
import 'package:currency/Pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoFiat"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(key: UniqueKey()),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Settings(key: UniqueKey()),
              ),
            ),
          )
        ],
      ),
      body: Consumer<CurrModel>(
        builder: (context, cmod, child) {
          if (cmod.currList.isEmpty) {
            return Center(
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Use ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.add_circle),
                      Text(
                        ' to add.',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(
                        'Use ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.settings),
                      Text(
                        ' to change base.',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => cmod.changeBase(cmod.currentBase),
            child: ListView.builder(
              itemCount: cmod.currList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(() {
                    if (!cmod.cry.containsValue(cmod.currList[index].name)) {
                      return 'Fiat';
                    } else {
                      return 'Crypto';
                    }
                  }()),
                  title: Text(cmod.currList[index].name.toString()),
                  subtitle: Text(() {
                    if (!cmod.cry.containsValue(cmod.currList[index].name)) {
                      return '${cmod.currentBase} to ${cmod.currList[index].name.toString()}';
                    } else {
                      return '${cmod.currList[index].name.toString()} to ${cmod.currentBase}';
                    }
                  }()),
                  trailing: Text(cmod.currList[index].price.toString()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
