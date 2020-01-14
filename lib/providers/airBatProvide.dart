/*
 * @Author: liangyt
 * @Date: 2020-01-07 17:47:50
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-14 14:28:44
 * @Description: 空调 蓄电池，常规动力设备详情
 * @FilePath: /unicom_flutter/lib/providers/airBatProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/airBatModel.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/utils/index.dart';

class AirBatProvide with ChangeNotifier {
  int id;
  bool isLoad = false;
  List<dynamic> lastData = [];
  AirBatModel pageData;

  // 获取页面数据
  void getData(BuildContext context, int myId, List<dynamic> lastPage) async {
    id = myId;
    lastData = lastPage;
    isLoad = false;
    var params = {"id": myId};
    await HttpUtil.request(context, 'jobDetail', data: params).then((data) {
      AirBatModel dataInfo = AirBatModel.fromJson(data);
      isLoad = true;
      pageData = dataInfo;
    });
    notifyListeners();
  }

  void submit(context) async {
    Utils.showLoading(context, title: '正在回单');
    var params = {'id': id};
    await HttpUtil.request(context, 'receipt', data: params).then((data) {
      if (data != null) {
        Provide.value<OrderDetailsProvide>(context).callRefresh();
        Navigator.pop(context);
        Navigator.pop(context);
        Utils.showToast('回单完成');
      }
    });
  }
}
