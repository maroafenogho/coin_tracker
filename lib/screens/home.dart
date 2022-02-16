import 'package:coin_tracker/tools/api_service.dart';
import 'package:coin_tracker/tools/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final apiController = Get.put(ApiController());
  final authController = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            child: TextButton(
                onPressed: () {
                  apiController.getCoinInfo();
                },
                child: Text('data')),
          ),
          Container(
            child: TextButton(
                onPressed: () {
                  authController.signOut();
                },
                child: Text('logout')),
          )
        ],
      )),
    );
  }
}
