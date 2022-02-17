class CoinInfo {
  String? coinName;
  double? coinPrice;
  String? fiat;

  CoinInfo(this.coinName, this.fiat, this.coinPrice);

  factory CoinInfo.fromJson(Map coin) {
    return CoinInfo(
        coin["asset_id_base"], coin["asset_id_quote"], coin["rate"]);
  }
}
