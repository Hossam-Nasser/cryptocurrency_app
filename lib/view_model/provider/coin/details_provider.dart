import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_flutter/models/coin_detail_model.dart';

import '../../../network/coin_api.dart';
import '../../../network/dio_exceptions.dart';
import '../../../view/screens/coin/details_screen.dart';

class DetailsProvider extends ChangeNotifier {
  CoinDetailsModel? coinDetails;

  bool isLoading = false;


  getCoinDetails(String id) async {
    isLoading = true;
    try {
      Get.to(DetailsScreen());
      await CoinApi().getCoinDetails(id).then((value) {
        coinDetails = value;
        isLoading = false;
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
                getCoinDetails(id);
                Get.back();
              },
              child: Text('Ok'))
        ],
      ));
    }

  }
}