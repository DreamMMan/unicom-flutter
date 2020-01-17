/*
 * @Author: liangyt
 * @Date: 2020-01-07 14:35:00
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-17 10:31:35
 * @Description: 常规动力站点详情
 * @FilePath: /unicom_flutter/lib/providers/rpinsProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/rpisnModel.dart';
import 'package:unicom_flutter/providers/orderDetailsProvide.dart';
import 'package:unicom_flutter/utils/index.dart';

class RpinsProvide with ChangeNotifier {
  int id;
  bool isLoad = false;
  RpinsModel siteData;

  // 获取数据
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

  // 刷新数据
  void callRefresh(BuildContext context) async {
    var params = {"id": id};
    await HttpUtil.request(context, 'appSiteDetail', data: params).then((data) {
      RpinsModel dataInfo = RpinsModel.fromJson(data);
      siteData = dataInfo;
    });
    notifyListeners();
  }

  // 提交数据
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
      Navigator.pop(context);
      if (data != null) {
        Provide.value<OrderDetailsProvide>(context).callRefresh();
        Navigator.pop(context);
        Utils.showToast('回单完成');
      }
    });
  }
}
