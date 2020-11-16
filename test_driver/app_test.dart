// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:bitcoin_calculator/config/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

void main() {
  FlutterDriver driver;
  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });
  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  final homePage = find.byValueKey('homepage');
  final usdButton = find.byValueKey('USDtoBTC');
  final btcButton = find.byValueKey('BTCtoUSD');
  final usdtobtcResult = find.byValueKey('dollartobtc');
  final btctodollarResult = find.byValueKey('btctodollar');
  final usdtextField = find.byValueKey('usdtextfield');
  final btctextField = find.byValueKey('btctextfield');
  final backUsd = find.byValueKey('backUSD');
  final backBtc = find.byValueKey('backBTC');

  group('Fetch Fake Values', () {
    test(
        'Goes to API grabs a updated value but we forced code a static number instead',
        () async {
      await driver.tap(usdButton);
      await driver.tap(usdtextField);
      await driver.enterText('15990.6483');
      await Future.delayed(const Duration(seconds: 1));
      await driver.waitFor(find.text('15990.6483'));
      expect(await driver.getText(usdtobtcResult), " BTC 1.0");
      await driver.tap(backUsd);
      expect(await driver.getText(homePage), "USD/BTC Calculator Homepage");
    });
  });

  group('Bitcoin Calculator Happy Paths', () {
    /*
      Given I am on the USD/BTC Calculator Homepage
      When I tap "USD to BTC"
      And I enter "1"
      Then I should see " BTC 0.000072"
    */
    test('Check that convertion from USD to BTC works', () async {
      await driver.tap(usdButton);
      await driver.tap(usdtextField);
      await driver.enterText('1');
      await Future.delayed(const Duration(seconds: 1));
      await driver.waitFor(find.text('1'));
      expect(
          await driver.getText(usdtobtcResult), " BTC 0.00006253655144175737");
      await driver.tap(backUsd);
      expect(await driver.getText(homePage), "USD/BTC Calculator Homepage");
    });
/*
      Given I am on the USD/BTC Calculator Homepage
      When I tap "BTC to USD"
      And I enter "1"
      Then I should see " USD 13804."
    */
    test('Check that convertion from BTC to USD works', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      await driver.tap(btcButton);
      await driver.tap(btctextField);
      await driver.enterText('1');
      await Future.delayed(const Duration(seconds: 1));
      await driver.waitFor(find.text('1'));
      expect(await driver.getText(btctodollarResult), " USD 15990.6483");
      await driver.tap(backBtc);
      expect(await driver.getText(homePage), "USD/BTC Calculator Homepage");
    });
  });

//We did not use any sad path testing since there is no sad paths to test.
//our app does not allow negatives and accepts nonzero numbers only.
  group('Bitcoin Calculator Sad Paths', () {
    /*
      Given I am on the USD/BTC Calculator Homepage
      When I tap "USD to BTC"
      And I enter "0"
      Then I should not be able to see as it is transparent.
    */
    // test('Check that the USD input doesnt not accept 0', () async {
    //   await driver.tap(usdButton);
    //   await driver.tap(usdtextField);
    //   await driver.enterText('0');
    //   await Future.delayed(const Duration(seconds: 1));
    //   await driver.waitFor(find.text('0'));
    //   expect(await driver.getText(usdtobtcResult), "0");
    // });

    // test('Check that the BTC input doesnt not accept 0', () async {
    //   await driver.tap(btcButton);
    //   await driver.tap(btctextField);
    //   await driver.enterText('0');
    //   await Future.delayed(const Duration(seconds: 1));
    //   await driver.waitFor(find.text('0'));
    //   expect(await driver.getText(btctodollarResult), "0");
    // });
  });
}
