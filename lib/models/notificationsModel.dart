class NotificationsModel {
  String? coinName;
  String? directionKeyword;
  int? oldPrice;
  int? newPrice;

  NotificationsModel({
    this.coinName,
    this.directionKeyword,
    this.oldPrice,
    this.newPrice,
  });

  factory NotificationsModel.fromMap(Map map) {
    return NotificationsModel(
      coinName: map['coinName'],
      directionKeyword: map['directionKeyWord'],
      oldPrice: map['oldPrice'],
      newPrice: map['newPrice'],
    );
  }
}
