import 'package:bitcoin_calculator/3BTCtoUSD.dart';
import 'package:flutter/material.dart';
import '2USDtoBTC.dart';
import '3BTCtoUSD.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'BTC/USD Calculator', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4D4B4B),
      appBar: AppBar(
        title: Text(
          "USD/BTC Calculator Homepage",
          key: Key('homepage'),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Shape of the USD to BTC button
            SizedBox(
              height: 45,
              width: 200,
              child: RaisedButton(
                color: Colors.green[200],
                child: Text(
                  "USD  to  BTC",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                //test
                key: Key("USDtoBTC"),
                //navigate to BTC page
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => USD()));
                },
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            //Shape of the BTC to USD button
            SizedBox(
              height: 45,
              width: 200,
              child: RaisedButton(
                color: Colors.red[200],
                child: Text(
                  "BTC  to  USD",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                //test
                key: Key("BTCtoUSD"),
                //navigate to BTC page
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => BTC()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
