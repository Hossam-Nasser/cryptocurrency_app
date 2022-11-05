class CoinDetailsModel {
  final String id;
  final String name;
  final String symbol;
  final int rank;
  final String imgURL;
  var currentPrice;
  final String description;
  final double percentChange_24h;
  final double percentChange_7d;
  final double percentChange_14;
  final double percentChange_30;
  final double percentChange_60;
  final double percentChange_200;
  final double percentChange_1y;


  CoinDetailsModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.rank,
    required this.imgURL,
    required this.currentPrice,
    required this.description,
    required this.percentChange_24h,
    required this.percentChange_7d,
    required this.percentChange_14,
    required this.percentChange_30,
    required this.percentChange_60,
    required this.percentChange_200,
    required this.percentChange_1y,
  });

  factory CoinDetailsModel.fromJson(Map<String, dynamic> json) {
    return CoinDetailsModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      rank: json["market_cap_rank"],
      imgURL: json['image']['large'],
      currentPrice: json['market_data']['current_price']['usd'],
      description: json['description']['en'],
      percentChange_24h: json["market_data"]["price_change_percentage_24h"],
      percentChange_7d: json["market_data"]["price_change_percentage_7d"],
      percentChange_14: json["market_data"]["price_change_percentage_14d"],
      percentChange_30: json["market_data"]["price_change_percentage_30d"],
      percentChange_60: json["market_data"]["price_change_percentage_60d"],
      percentChange_200: json["market_data"]["price_change_percentage_200d"],
      percentChange_1y: json["market_data"]["price_change_percentage_1y"],
    );
  }


}

