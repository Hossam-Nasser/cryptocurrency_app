// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intro_flutter/main.dart';
import 'package:intro_flutter/models/coin_detail_model.dart';
import 'package:intro_flutter/models/coin_model.dart';
import 'package:intro_flutter/models/search_model.dart';
import 'package:intro_flutter/network/coin_api.dart';
import 'package:intro_flutter/view_model/provider/coin/home_provider.dart';
import 'package:mocktail/mocktail.dart';

int sum(int a, int b) {
  return a + b;
}


class MockCoinApi extends Mock implements HomeProvider {}


void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  //late HomeProvider coinApi;


  test('adds one to input values', () {
    expect(HomeProvider().coins, []);
  });

  setUp(() => {
   // coinApi = MockCoinApi()
  });


  group("getCoins", () {

    test("get all coins",
            ()async {
      when(()=> MockCoinApi().getAllCoin()).thenAnswer((_) async => []);
      await HomeProvider().getAllCoin();
      verify(() => HomeProvider().getAllCoin()).called(1);

    });

    test("indicates loading",
            ()async {
      when(()=> MockCoinApi().getAllCoin()).thenAnswer((_) async => [
        CoinModel(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            currentPrice: 1.0,
          priceChange: 1.0,
          priceChangePercentage: 1.0,
          rank: 1
        ),
        CoinModel(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            currentPrice: 1.0,
            priceChange: 1.0,
            priceChangePercentage: 1.0,
            rank: 1
        ),
        CoinModel(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            currentPrice: 1.0,
            priceChange: 1.0,
            priceChangePercentage: 1.0,
            rank: 1
        ),
      ]);
      final future = HomeProvider().getAllCoin();
      expect(HomeProvider().coins.length, 0 );
      await future;
      // expect(HomeProvider().coins,[
      //   CoinModel(
      //       id: "bitcoin",
      //       symbol: "btc",
      //       name: "Bitcoin",
      //       imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      //       currentPrice: 1.0,
      //       priceChange: 1.0,
      //       priceChangePercentage: 1.0,
      //       rank: 1
      //   ),
      //   CoinModel(
      //       id: "bitcoin",
      //       symbol: "btc",
      //       name: "Bitcoin",
      //       imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      //       currentPrice: 1.0,
      //       priceChange: 1.0,
      //       priceChangePercentage: 1.0,
      //       rank: 1
      //   ),
      //   CoinModel(
      //       id: "bitcoin",
      //       symbol: "btc",
      //       name: "Bitcoin",
      //       imgURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      //       currentPrice: 1.0,
      //       priceChange: 1.0,
      //       priceChangePercentage: 1.0,
      //       rank: 1
      //   ),
      // ]);

      expect(HomeProvider().coins.length != 0, false );

    });
  });








}





