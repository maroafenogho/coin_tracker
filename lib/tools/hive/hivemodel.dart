class HiveModel {
  int? btcPrice;
  int? ethPrice;
  String? time;
  HiveModel({this.btcPrice, this.ethPrice, this.time});

  factory HiveModel.fromMap(Map map) {
    return HiveModel(
      btcPrice: map['btcPrice'],
      ethPrice: map['ethPrice'],
      time: map['date'],
    );
  }
}
