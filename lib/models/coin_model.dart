class CoinModel {

  final String id;
  final String name;
  final String symbol;
  final String imgURL;
  var currentPrice;
  final int rank;
  final double priceChange;
  final double priceChangePercentage;


  CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.rank,
    required this.imgURL,
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercentage,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      imgURL: json['image'],
      rank: json['market_cap_rank'],
      currentPrice: json['current_price'],
      priceChange: json['price_change_24h'],
      priceChangePercentage: json['price_change_percentage_24h'],
    );
  }




}