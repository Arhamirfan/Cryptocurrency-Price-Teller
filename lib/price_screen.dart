import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'CryptoCard.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> AndroidDropDown() {
    List<DropdownMenuItem<String>> dropdownitems = [];

    for (String currency in currenciesList) {
      var newitem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownitems.add(newitem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownitems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        print(value);
      },
    );
  }

  CupertinoPicker IOSpicker() {
    List<Text> pickerItem = [];
    for (String currency in currenciesList) {
      var newitemlist = Text(currency);
      pickerItem.add(newitemlist);
    }
    return CupertinoPicker(
        itemExtent: 30,
        onSelectedItemChanged: (currentIndex) {
          selectedCurrency = currenciesList[currentIndex];
          print(currentIndex);
        },
        children: pickerItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PriceCard(selectedcurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? AndroidDropDown() : IOSpicker(),
          ),
        ],
      ),
    );
  }
}
