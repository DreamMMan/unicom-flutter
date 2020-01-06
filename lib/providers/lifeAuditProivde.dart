/*
 * @Author: liangyt
 * @Date: 2020-01-06 19:45:55
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-06 20:04:46
 * @Description: 生命周期工单
 * @FilePath: /unicom-flutter/lib/providers/lifeAuditProivde.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/utils/index.dart';

class LifeAuditProvide with ChangeNotifier {
  int id;
  bool isOdd = false; // 是否是调拨
  String description = '';
  bool adopt = true;
  String odd = '';
  String oddImage = '';

  void setId(int myId, bool isOd) {
    id = myId;
    isOdd = isOd;
    notifyListeners();
  }

  void setData({des, ado, od, oddIcon}) {
    description = des ?? description;
    adopt = ado ?? adopt;
    odd = od ?? odd;
    oddImage = oddIcon ?? oddImage;
    notifyListeners();
  }

  void submit(context) async {
    var params = {
      "id": id,
      "adopt": adopt,
      'description': description,
      'odd': odd,
      'oddIamge': oddImage
    };
    await HttpUtil.request(context, 'handAlarm', data: params).then((data) {
      if (data != null) {
        description = '';
        adopt = true;
        odd = '';
        oddImage = '';
        Utils.showToast('处理成功！');
        // Provide.value<AlarmProvide>(context).setCallRefresh();
        // for (var i = 0; i < backNum; i++) {
        //   Navigator.pop(context);
        // }
        notifyListeners();
      }
    });
  }
}
