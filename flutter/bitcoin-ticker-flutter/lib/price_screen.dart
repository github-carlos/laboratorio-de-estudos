import 'dart:convert';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  CupertinoPicker iosPicker() {
    return CupertinoPicker(itemExtent: 32.0, onSelectedItemChanged: (value) {
      selectedCurrency = currenciesList[value];
      updateValues();
    }, children: currenciesList.map((currency) {
    return Text(currency, style: TextStyle(color: Colors.white),);
    }).toList());
  }

  DropdownButton androidPicker() {
    return DropdownButton(
      value: selectedCurrency,
      items: currenciesList.map((String currency) {
      return DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateValues();
        });
      },
    );
  }

  Future<String> getCoinValue(cripto, currency) async {
    final response = await http.get('${this.coinApiBaseURL}$cripto/$currency', headers: {'x-CoinAPI-Key': '1AEAAB6E-D362-4CFC-B9FC-C28EA7411050'});
    dynamic parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse['rate']?.toStringAsFixed(2) ?? '?';
  }
  void getCoinValues()  {
    print('running');
    print(cryptoValues);
    cryptoValues.forEach((key, value) async {
      cryptoValues[key] = await getCoinValue(key, selectedCurrency);
    });
    setState(() {

    });
  }

  void updateValues() {
    getCoinValues();
  }

  List<Widget> createButtons() {
   return cryptoList.map((crypto) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${cryptoValues[crypto]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
   }).toList();
  }

  initState() {
    super.initState();
    cryptoList.forEach((element) {
      this.cryptoValues[element] = '?';
    });
  }

  String coinApiBaseURL = 'https://rest.coinapi.io/v1/exchangerate/';
  String selectedCurrency = 'USD';

  Map<String, String> cryptoValues = Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
           children: createButtons(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidPicker() : iosPicker(),
      ),
     ]
    ));
  }
}

