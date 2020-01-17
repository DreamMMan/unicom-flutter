/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:29:04
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 14:30:32
 * @Description: 设定表/传感器
 * @FilePath: /unicom_flutter/lib/providers/meterProvide.dart
 */

import 'package:flutter/material.dart';

class MeterProvide with ChangeNotifier {
  int id;

  void setData(int myId) {
    id = myId;
    notifyListeners();
  }
}
