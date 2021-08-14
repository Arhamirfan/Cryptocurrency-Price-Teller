import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'networking.dart';

class PriceCard extends StatefulWidget {
  PriceCard({this.selectedcurrency});

  String selectedcurrency;
  @override
  _PriceCardState createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  String c_selected, SelectedCrypto, SelectedCurrency;
  List<String> cryptoPrice = [];
  List cryptoprice = ['?', '?', '?', '?', '?'];
  bool isWaiting = false, isStarted = true;
  int counter = 0;
  @override
  void initState() {
    super.initState();
    getData(widget.selectedcurrency);
  }

  void getData(var currency) async {
    try {
      cryptoprice = ['?', '?', '?', '?', '?'];
      setState(() {
        SelectedCurrency = currency;
        SelectedCrypto = c_selected;
      });
      isWaiting = true;
      Networking networking = Networking();
      for (String cryptoName in cryptoList) {
        var cryptoData = await networking.getData(
            cryptocurrency: cryptoName, currency: SelectedCurrency);
        try {
          var data = cryptoData.toStringAsFixed(2);
          cryptoPrice.add(data);
          counter++;
          if (counter == 5) {
            break;
          }
        } catch (e) {
          print(e);
          counter = 0;
          cryptoPrice = [''];
        }
      }
      counter = 0;
      isWaiting = false;
      setState(() {
        cryptoprice.clear();
        cryptoprice = cryptoPrice;
      });

      for (String priceslist in cryptoprice) {
        print(priceslist + '\n');
      }
    } catch (e) {
      print(e);
      counter = 0;
      cryptoPrice = [''];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Wrap(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    c_selected = cryptoList[index];
                    return Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 ${cryptoList[index]} = ${cryptoprice[index]} $SelectedCurrency',
                          //
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cryptoList.length,
                ),
              ],
            )),
        FlatButton(
            onPressed: () {
              getData(widget.selectedcurrency);
            },
            child: Icon(
              Icons.refresh,
              size: 50,
              color: Colors.black,
            ))
      ],
    );
  }
}
