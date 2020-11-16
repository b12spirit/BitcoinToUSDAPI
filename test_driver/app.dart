import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:bitcoin_calculator/config/globals.dart' as globals;

class MockClient extends Mock implements http.Client {}

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();
  final MockClient client = MockClient();

  final fakeValueAPIData =
      '{ "bpi":{"USD":{"code":"USD","rate":"15,990.6483","description":"United States Dollar","rate_float":15990.6483}}}';
  when(client.get('https://api.coindesk.com/v1/bpi/currentprice/usd.json'))
      .thenAnswer((_) async => http.Response(fakeValueAPIData, 200));

  globals.httpClient = client;

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
