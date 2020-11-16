import 'package:bitcoin_calculator/utils/calculations.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group("USD and BTC calculations", () {
    group('fetchBitcoin', () {
      test('return rate float if the http call completes successfully',
          () async {
        final client = MockClient();
        final fakeRateAPIData =
            '{ "bpi": {  "USD": {  "code": "USD", "rate": "15,990.6483", "description": "United States Dollar", "rate_float":15990.6483}} }';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client
                .get('https://api.coindesk.com/v1/bpi/currentprice/usd.json'))
            .thenAnswer((_) async => http.Response(fakeRateAPIData, 200));

        //the extracted data from JSON
        double ratefloat = await CurrencyAPI.fetchCurrency(client);

        //we extract a double so we expect a double
        expect(ratefloat, isA<double>());

        //does the extracted value match our fake data?
        expect(ratefloat, 15990.6483);
      });
      test('throws an exception if the http call completes with an error', () {
        final client = MockClient();

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(client
                .get('https://api.coindesk.com/v1/bpi/currentprice/usd.json'))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(CurrencyAPI.fetchCurrency(client), throwsException);
      });
    });
    test('calculations USD  15990.6483 to BTC', () {
      double btc = CalculationsFake.usdtobtc(15990.6483);
      expect(btc, 1.0);
    });

    test('Calculate USD 1 to BTC', () {
      double btc = CalculationsFake.usdtobtc(1);
      expect(btc, 1 / 15990.6483);
    });

    test('Calculate BTC 1 to USD', () {
      double btc = CalculationsFake.btctousd(1);
      expect(btc, 15990.6483);
    });

    test('Calculate BTC 2 to USD', () {
      double btc = CalculationsFake.btctousd(2);
      expect(btc, 15990.6483 * 2);
    });
  });
}
