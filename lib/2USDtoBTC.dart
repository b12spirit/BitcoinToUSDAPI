import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitcoin_calculator/utils/calculations.dart';
import 'package:bitcoin_calculator/config/globals.dart';

class USD extends StatefulWidget {
  @override
  _USDState createState() => _USDState();
}

class _USDState extends State<USD> {
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
            title: Text('                  USD to BTC', key: Key('USD-page')),
            leading: IconButton(
              key: Key("backUSD"),
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
                    //control what is viewed on text based on boolean
                    child: !resultcolor
                        ? Text("", style: TextStyle(color: Color(0xffFFFFFF)))
                        : Text(" BTC $result",
                            //test
                            key: Key('dollartobtc'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.green[600])),
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
                        key: Key('usdtextfield'),
                        decoration: InputDecoration.collapsed(
                          fillColor: Color(0xffFFFFFF),
                          hintText: "Please input valid number value",
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny('-'),
                        ],
                        //convert string to double and control boolean for our above textfield
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
                                //use our calculation function to convert usd to btc
                                result = Calculations.usdtobtc(result);
                              });
                            }
                          });
                        }),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<double>(
                    future: currency,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        double price = snapshot.data;
                        return Text("Current Dollar Price per BTC: $price",
                            key: Key("price-text"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ])));
  }
}
