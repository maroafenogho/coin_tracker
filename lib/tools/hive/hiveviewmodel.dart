import 'package:coin_tracker/tools/hive/hivemodel.dart';

class HiveViewModel {
  HiveModel? hiveModel;
  HiveViewModel({this.hiveModel});

  int get btcPrice {
    return hiveModel!.btcPrice!;
  }

  int get ethPrice {
    return hiveModel!.ethPrice!;
  }

  String get time {
    return hiveModel!.time!;
  }
}
