/*
 * @Author: liangyt
 * @Date: 2019-12-23 14:27:18
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-24 09:20:48
 * @Description: 告警处理
 * @FilePath: /unicom_flutter/lib/providers/alarmDealProvide.dart
 */
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/providers/alarmProvide.dart';
import 'package:unicom_flutter/utils/index.dart';

class AlarmDealProvide with ChangeNotifier {
  List<int> idList = [];
  bool checked = true;
  int backNum = 1;
  String description = '';

  void setId(ids, _num) {
    idList = ids;
    backNum = _num;
    checked = true;
    notifyListeners();
  }

  void setCheck(bool bol) {
    checked = bol;
    notifyListeners();
  }

  void setTxt(String txt) {
    description = txt;
    notifyListeners();
  }

  void submit(context) async {
    var params = {
      "ids": idList,
      "remove": checked,
      'handDescription': description
    };
    await HttpUtil.request(context, 'handAlarm', data: params).then((data) {
      if (data != null) {
        Utils.showToast('处理成功！');
        Provide.value<AlarmProvide>(context).setCallRefresh();
        for (var i = 0; i < backNum; i++) {
          Navigator.pop(context);
        }
      }
    });
  }
}
