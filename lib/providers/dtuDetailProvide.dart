/*
 * @Author: liangyt
 * @Date: 2020-01-17 14:27:21
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 14:28:47
 * @Description: DTU详情
 * @FilePath: /unicom_flutter/lib/providers/dtuDetailProvide.dart
 */

import 'package:flutter/material.dart';

class DtuDetailProvide with ChangeNotifier{
  int id;

  void setData(int myId){
    id = myId;
    notifyListeners();
  }
}
