import 'dart:convert';
import 'package:http/http.dart' as http;

double bitcoinvalue;

class CurrencyAPI {
  static Future<double> fetchCurrency(http.Client client) async {
    final response = await client
        .get('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      bitcoinvalue = json["bpi"]["USD"]["rate_float"];
      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to load a value');
    }
  }
}

class Calculations {
  static double usdtobtc(double dollar) {
    return dollar / bitcoinvalue;
  }

  static double btctousd(double bitcoin) {
    return bitcoin * bitcoinvalue;
  }
}

class CalculationsFake {
  static double usdtobtc(double dollar) {
    return dollar / 15990.6483;
  }

  static double btctousd(double bitcoin) {
    return bitcoin * 15990.6483;
  }
}
