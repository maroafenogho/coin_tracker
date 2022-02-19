import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveController extends GetxController {
 Future openHiveBox()async{
   await Hive.openBox('coins');
 }
  
}
