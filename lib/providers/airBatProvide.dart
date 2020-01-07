/*
 * @Author: liangyt
 * @Date: 2020-01-07 17:47:50
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-07 18:16:15
 * @Description: 空调 蓄电池，常规动力设备详情
 * @FilePath: /unicom_flutter/lib/providers/airBatProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/rpisnModel.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/utils/index.dart';

class AirBatProvide with ChangeNotifier {
  int id;
  bool isLoad = false;
  RpinsModel siteData;
  
  void getData(BuildContext context, int myId) async {
    id = myId;
    isLoad = false;
    var params = {"id": myId};
    await HttpUtil.request(context, 'appSiteDetail', data: params).then((data) {
      RpinsModel dataInfo = RpinsModel.fromJson(data);
      isLoad = true;
      siteData = dataInfo;
    });
    notifyListeners();
  }

  void submit(context) async {
    var unfinished;
    for (int i = 0; i < siteData.jobList.length; i++) {
      if (!siteData.jobList[i].submit) {
        unfinished = siteData.jobList[i];
        break;
      }
    }
    if (unfinished != null) {
      Utils.showToast('请完成${unfinished.name}作业');
      return;
    }
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
