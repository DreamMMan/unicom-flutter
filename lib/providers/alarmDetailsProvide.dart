/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:29:16
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-03 16:26:49
 * @Description: 告警处理详情
 * @FilePath: /unicom_flutter/lib/providers/dealDetailsProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/alarmDetailsModel.dart';

class AlarmDetailsProvide with ChangeNotifier {
  int id;
  bool isLoad = false;
  AlarmDetailsModel pageData;

  void setId(context, myId) async {
    id = myId;
    pageData = null;
    isLoad = false;
    var params = {"id": myId};
    await HttpUtil.request(context, 'alarmDetail', data: params).then((data) {
      AlarmDetailsModel dataInfo = AlarmDetailsModel.fromJson(data);
      isLoad = true;
      pageData = dataInfo;
    });
    notifyListeners();
  }
}
