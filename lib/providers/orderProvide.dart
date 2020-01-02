/*
 * @Author: liangyt
 * @Date: 2019-12-20 16:27:24
 * @LastEditors  : liangyt
 * @LastEditTime : 2020-01-02 17:27:12
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
  bool planCallRefresh = false;
  List<MyList> planList = [];
  // 生命周期工单
  int lifePage = 0;
  int lifeTotal = 0;
  bool lifeFirst = true;
  bool lifeCallRefresh = false;
  List<MyList> lifeList = [];

  // 设置刷新
  void setCallRefresh(bool isPlan) {
    if (isPlan) {
      planCallRefresh = true;
    } else {
      lifeCallRefresh = true;
    }
  }

  // 下拉刷新
  onRefresh(context, bool isPlan) async {
    isError = false;
    if (isPlan) {
      planFirst = false;
      planCallRefresh = false;
    } else {
      lifeFirst = false;
      lifeCallRefresh = false;
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
