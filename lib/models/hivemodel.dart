class HiveModel {
  String? coinName;
  String? coinPrice;
  String? time;
  HiveModel({this.coinName, this.coinPrice, this.time});

  factory HiveModel.fromMap(Map map) {
    return HiveModel(
      coinName: map['coinName'],
      coinPrice: map['coinPrice'],
      time: map['time'],
    );
  }
}
