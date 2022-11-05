import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/coin_model.dart';
import '../../../network/coin_api.dart';
import '../../../network/dio_exceptions.dart';

class HomeProvider extends ChangeNotifier {

  List<CoinModel> coins = [];

  HomeProvider(){
    getAllCoin();
  }

  Future<void> getAllCoin() async {
    try {
      await CoinApi().getAllCoin().then((value) {
        coins = value;
        notifyListeners();
      });
    } on DioError  catch (e) {
      String error = DioExceptions.fromDioError(e).toString();
      print(error);

      Get.dialog(
        AlertDialog(
          title: Text("Error"),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                getAllCoin();
                Get.back();
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );

    }
  }


  // void getAllCoin() async {
  //   try {
  //     await CoinApi().getAllCoin().then((value) {
  //       coins = value;
  //       notifyListeners();
  //     });
  //
  //   } on DioError catch (e) {
  //     String error = DioExceptions.fromDioError(e).toString();
  //     Get.dialog(AlertDialog(
  //       title: Text('Error'),
  //       content: Text(error),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               getAllCoin();
  //               Get.back();
  //             },
  //             child: Text('Ok'))
  //       ],
  //     ));
  //   }
  // }
}