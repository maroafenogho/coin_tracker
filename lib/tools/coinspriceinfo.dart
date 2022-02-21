class CoinsPriceInfo {
  int? btcPrice;
  int? ethPrice;

  CoinsPriceInfo({this.btcPrice, this.ethPrice});

  factory CoinsPriceInfo.fromMap(Map priceInfo) {
    return CoinsPriceInfo(
        btcPrice: priceInfo['btcPrice'], ethPrice: priceInfo['ethPrice']);
  }
}
