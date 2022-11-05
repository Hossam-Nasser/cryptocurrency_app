import 'package:dio/dio.dart';

import '../core/constants.dart';
import '../models/coin_detail_model.dart';
import '../models/search_model.dart';
import '../models/coin_model.dart';

class CoinApi {





  Future<List<CoinModel>> getAllCoin()async{

    try {
      final response = await Dio().get(baseUrl + allCoinEndPoint);

      return
        List<CoinModel>.from(
            response.data.map((x) => CoinModel.fromJson(x)));
    } catch(e){
      rethrow;
    }
  }

  Future<CoinDetailsModel> getCoinDetails(String id)async{

    try {
      final response = await Dio().get(baseUrl + coinDetailsEndPoint + id);
      return CoinDetailsModel.fromJson(response.data);
    } catch(e){
      rethrow ;
    }
  }

  Future<List<SearchModel>> SearchCoin(String value)async{

    try {
      final response = await Dio().get(baseUrl + searchCoinEndPoint + value);
      print(response.data);
      return List<SearchModel>.from(
          response.data['coins'].map((x) => SearchModel.fromJson(x)));
    } catch(e){
      print(e);
      throw e;
    }
  }
}