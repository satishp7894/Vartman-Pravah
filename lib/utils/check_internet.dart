import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'alerts.dart';

class CheckInternet{
  static Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
      Alerts.showAlertAndBack( "No Internet Connection", "Please check your internet");
      // print(InternetConnectionChecker().lastTryResults);
    }
  }
}