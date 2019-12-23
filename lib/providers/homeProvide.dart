/*
 * @Author: liangyt
 * @Date: 2019-12-23 16:58:48
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 17:00:04
 * @Description: home
 * @FilePath: /unicom_flutter/lib/providers/homeProvide.dart
 */
import 'package:flutter/material.dart';

class HomeProvide with ChangeNotifier {
  int current = 0;

  setCurrent(int index) {
    current = index;
    notifyListeners();
  }
}
