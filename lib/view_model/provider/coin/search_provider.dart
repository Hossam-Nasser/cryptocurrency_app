import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/search_model.dart';
import '../../../network/coin_api.dart';
import '../../../network/dio_exceptions.dart';

class SearchProvider extends ChangeNotifier {


  List<SearchModel> searchCoins = [];

  void getSearchCoin(String value) async {
    try {
      CoinApi().SearchCoin(value).then((value) {
        searchCoins = value;
        print(searchCoins);
        notifyListeners();
      });
    } on DioError catch (e) {
      String error = DioExceptions.fromDioError(e).toString();
      Get.dialog(AlertDialog(
        title: Text('Error'),
        content: Text(error),
        actions: [
          TextButton(
              onPressed: () {
                getSearchCoin(value);
                Get.back();
              },
              child: Text('Ok'))
        ],
      ));
    }
  }
}