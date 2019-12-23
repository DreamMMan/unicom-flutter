/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:27:18
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 14:36:27
 * @Description: 告警处理
 * @FilePath: /unicom_flutter/lib/providers/alarmDealProvide.dart
 */
import 'package:flutter/material.dart';

class AlarmDealProvide with ChangeNotifier {
  List<int> idList = [];

  void setId(ids) {
    idList = ids;
    print(ids);
    notifyListeners();
  }
}
