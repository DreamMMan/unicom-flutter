/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:29:16
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-23 14:36:35
 * @Description: 告警处理详情
 * @FilePath: /unicom_flutter/lib/providers/dealDetailsProvide.dart
 */
import 'package:flutter/material.dart';

class DealDetailsProvide with ChangeNotifier {
  int id;

  void setId(myId) {
    id = myId;
    print(myId);
    notifyListeners();
  }
}
