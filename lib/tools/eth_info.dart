class EthInfo {
  String? coinName;
  double? coinPrice;
  String? fiat;

  EthInfo(this.coinName, this.fiat, this.coinPrice);

  factory EthInfo.fromJson(Map coin) {
    return EthInfo(
        coin["asset_id_base"], coin["asset_id_quote"], coin["rate"]);
  }
}