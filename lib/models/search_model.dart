class SearchModel {
  // {
  // "id": "bitcoin",
  // "name": "Bitcoin",
  // "api_symbol": "bitcoin",
  // "symbol": "BTC",
  // "market_cap_rank": 1,
  // "thumb": "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png",
  // "large": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png"
  // },

  final String id;
  final String name;
  final String symbol;
  final int rank;
  final String imageUrl;



  SearchModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.rank,
    required this.imageUrl,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      rank: json["market_cap_rank"],
      imageUrl: json['large'],
    );
  }


}