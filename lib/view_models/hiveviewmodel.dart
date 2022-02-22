import 'package:coin_tracker/models/hivemodel.dart';

class HiveViewModel {
  HiveModel? hiveModel;
  HiveViewModel({this.hiveModel});

  int get coinPrice {
    return int.parse(hiveModel!.coinPrice!);
  }

  String get coinName {
    return hiveModel!.coinName!;
  }

  String get time {
    return hiveModel!.time!;
  }
}
