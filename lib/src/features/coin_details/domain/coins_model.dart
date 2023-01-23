class CoinModel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double marketCap;
  int marketRank;
  double totalVolume;
  double high24Hour;
  double low24Hour;
  double priceChange;
  double priceChangePercent;
  double totalSupply;
  double circulatingSupply;
  double maxSupply;
  double ath;
  double athChangePercent;
  String athDate;
  String atlDate;
  double atl;
  double atlChangePercent;
  bool isExpanded;

  CoinModel({
    required this.id,
    required this.symbol,
    required this.ath,
    required this.athChangePercent,
    required this.circulatingSupply,
    required this.currentPrice,
    required this.high24Hour,
    required this.image,
    required this.low24Hour,
    required this.marketCap,
    required this.marketRank,
    required this.maxSupply,
    required this.name,
    required this.priceChange,
    required this.priceChangePercent,
    required this.totalSupply,
    required this.totalVolume,
    required this.atl,
    required this.athDate,
    required this.atlDate,
    required this.atlChangePercent,
    this.isExpanded = false,
  });

  factory CoinModel.fromJson(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'],
      symbol: map['symbol'],
      ath: double.parse(map['ath'].toString()),
      athChangePercent: double.parse(map['ath_change_percentage'].toString()),
      circulatingSupply: double.parse(map['circulating_supply'].toString()),
      currentPrice: double.parse(map['current_price'].toString()),
      high24Hour: double.parse(map['high_24h'].toString()),
      image: map['image'],
      low24Hour: double.parse(map['low_24h'].toString()),
      marketCap: double.parse(map['market_cap'].toString()),
      marketRank: map['market_cap_rank'],
      maxSupply: map['max_supply'] != null
          ? double.parse(map['max_supply'].toString())
          : 0.0,
      name: map['name'],
      priceChange: double.parse(map['price_change_24h'].toString()),
      priceChangePercent:
          double.parse(map['price_change_percentage_24h'].toString()),
      totalSupply: map['total_supply'] != null
          ? double.parse(map['total_supply'].toString())
          : 0.0,
      totalVolume: double.parse(map['total_volume'].toString()),
      atl: map['atl'],
      atlChangePercent: map['atl_change_percentage'],
      athDate: map['ath_date'],
      atlDate: map['atl_date'],
    );
  }
}
