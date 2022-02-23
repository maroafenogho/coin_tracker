import 'package:coin_tracker/models/notificationsModel.dart';

class NotificationsViewModel {
  NotificationsModel? notificationsModel;
  NotificationsViewModel({this.notificationsModel});

  String get coinName {
    return notificationsModel!.coinName!;
  }

  String get directionWord {
    return notificationsModel!.directionKeyword!;
  }

  int get oldPrice {
    return notificationsModel!.oldPrice!;
  }

  int get newPrice {
    return notificationsModel!.newPrice!;
  }
}
