/*
 * @Author: liangyt
 * @Date: 2019-12-20 16:27:24
 * @LastEditors  : liangyt
 * @LastEditTime : 2019-12-21 11:01:17
 * @Description: 工单 provide
 * @FilePath: /unicom_flutter/lib/providers/orderProvide.dart
 */

import 'package:flutter/material.dart';
import 'package:unicom_flutter/http/httpUtil.dart';
import 'package:unicom_flutter/models/orderModel.dart';

class OrderProvide with ChangeNotifier {
  int size = 20;
  bool isError = false;
  // 作业计划工单
  int planPage = 0;
  int planTotal = 0;
  bool planFirst = true;
  List<MyList> planList = [];
  // 生命周期工单
  int lifePage = 0;
  int lifeTotal = 0;
  bool lifeFirst = true;
  List<MyList> lifeList = [];

  // 下拉刷新
  onRefresh(context, bool isPlan) async {
    isError = false;
    if (isPlan) {
      planFirst = false;
    } else {
      lifeFirst = false;
    }
    var params = {"page": 0, "size": size, "lifeCycle": !isPlan};
    await HttpUtil.request(context, 'orderList', data: params).then((data) {
      OrderModel dataInfo = OrderModel.fromJson(data);
      if (isPlan) {
        planPage = 0;
        planTotal = dataInfo.total;
        planList = dataInfo.list;
      } else {
        lifePage = 0;
        lifeTotal = dataInfo.total;
        lifeList = dataInfo.list;
      }
      notifyListeners();
    }).catchError((onError) {
      isError = true;
      notifyListeners();
    });
  }

  // 上拉加载
  onLoad(context, bool isPlan) async {
    isError = false;
    var params = {
      "page": isPlan ? planPage + 1 : lifePage + 1,
      "size": size,
      "lifeCycle": !isPlan
    };
    await HttpUtil.request(context, 'orderList', data: params).then((data) {
      OrderModel dataInfo = OrderModel.fromJson(data);
      if (isPlan) {
        planPage++;
        planTotal = dataInfo.total;
        planList..addAll(dataInfo.list);
      } else {
        lifePage++;
        lifeTotal = dataInfo.total;
        lifeList..addAll(dataInfo.list);
      }
      notifyListeners();
    }).catchError((onError) {
      isError = true;
      notifyListeners();
    });
  }
}
