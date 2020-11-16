import 'dart:ffi';

import 'package:bitcoin_calculator/config/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitcoin_calculator/utils/calculations.dart';

class BTC extends StatefulWidget {
  @override
  _BTCState createState() => _BTCState();
}

class _BTCState extends State<BTC> {
  double result;
  bool resultcolor = false;
  Future<double> currency;

  @override
  void initState() {
    super.initState();
    currency = CurrencyAPI.fetchCurrency(httpClient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff4D4B4B),
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('                  BTC to USD', key: Key('BTC-page')),
            leading: IconButton(
              key: Key("backBTC"),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff4C748B),
              ),
              //go to previous screen
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Container(
            padding: const EdgeInsets.all(40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: !resultcolor
                        ? Text("", style: TextStyle(color: Color(0xff0000)))
                        : Text(" USD $result",
                            //test
                            key: Key('btctodollar'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red[500])),
                  ),
                  //shape our textfield border
                  LimitedBox(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Color(0xffFFFFFF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        //test
                        key: Key('btctextfield'),
                        decoration: InputDecoration.collapsed(
                            hintText: "Please input valid number value"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny('-'),
                        ],
                        //converet string to double and control boolean of our above text field
                        onChanged: (value) {
                          setState(() {
                            result = double.tryParse(value);
                            if (value.isEmpty) {
                              setState(() {
                                resultcolor = false;
                              });
                            } else if (result > 0) {
                              setState(() {
                                resultcolor = true;
                                //use our calculation function to convert btc to usd
                                result = Calculations.btctousd(result);
                              });
                            }
                          });
                        }),
                  )),
                  Padding(padding: EdgeInsets.all(7)),
                  FutureBuilder<double>(
                    future: currency,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //double price = snapshot.data;
                        return Text("Current Bitcoin Price: $bitcoinvalue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            key: Key("price-text"));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ])));
  }
}
